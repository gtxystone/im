package com.yx.base.service.group;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.dataformat.yaml.snakeyaml.nodes.Node;
import com.framework.model.Page;
import com.framework.service.EntityServiceImpl;
import com.yx.base.extendmodel.ImGroupConfig;
import com.yx.base.extendmodel.ImGroupExtend;
import com.yx.base.extendmodel.ImGroupNote;
import com.yx.base.model.ImGroup;
import com.yx.base.model.ImGroupMember;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parames.WalletConstants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.CommonService;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.login.ReadyService;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.pay.PayService;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.YxUtil;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service
public class GroupService extends EntityServiceImpl {

	@Autowired
	private MessageFactory factory;

	@Autowired
	private MsgStoreAndNotify chatService;
	
	@Autowired
	private ReadyService readyService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WalletService walletService;
	
	@Autowired
	private PayService payService;

	/**
	 * 退出群
	 * 
	 * @param groupId
	 * @param userId
	 * @throws IOException 
	 */
	@Transactional
	public void updateQuitGroup(long groupId, long userId) throws IOException {
		ImMessage message = factory.quitGroupNotice(userId, groupId);
		List<Map<String, Object>> list = this.getAllMemberFromCache(groupId);
		for (Map<String, Object> map : list) {
			long memberId=Long.parseLong(map.get("userId").toString());
			if(memberId!=userId){
				//通知其它成员有人退出
				chatService.storeMsgAndNotifyImServer(message,memberId);
				
			}			
		}
		this.updateBySql("delete from im_group_member where groupId=? and userId=?", groupId, userId);
		readyService.cacheGroupsInfo(userId);
		
		//clean cache
		this.cleanGroupMemberCache(groupId);
	}

	
	public List<Map<String, Object>> getAllMemberFromCache(long groupId) throws IOException{

		List<Map<String, Object>> list = (List<Map<String, Object>>) queryForObjListBySql(
				"select a.userId,a.role,a.silence,IFNULL(a.markName,b.name) name,b.id,b.headUrl,b.province,b.city,b.district,b.sign from im_group_member a LEFT JOIN im_user b on(a.userId=b.id) where groupId=? and isAccept=1 group by userId ORDER BY rand()", groupId);

		return list;
	}
	
	/**
	 * 清空群成员缓存
	 * @param groupId
	 */
	public void cleanGroupMemberCache(long groupId){
		
	}
	
	public List<Map<String, Object>> cacheGroupMember(byte[] key,List<Map<String, Object>> members) throws IOException{
		return members;
	}

	public int updateGroup(long userId, long groupId, String name) throws IOException {
		int row = 0;
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group != null) {
			group.setName(name);
			this.update(group);
			row = 1;
			//通知群成员， 群名称被修改
			List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
			for(Map<String, Object> member:members){
				ImMessage msg = factory.modifyGroupNotice(userId, groupId,name);
				chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
			}
		}
		return row;
	}

	public int updateGroupMemberMark(long userId, long groupId, String markName) throws IOException {
		int row=0;
		row = this.updateBySql("update im_group_member set markName=? where groupId=? and userId=?", markName, groupId,
				userId);
		List<Map<String,Object>> members=this.getAllMemberFromCache(groupId);
		for(Map<String,Object> member:members){
			long memberId=Long.parseLong(member.get("userId").toString());
			if(memberId!=userId){
				ImMessage msg=factory.modifyGroupCommentNotice(userId, groupId, markName);
				chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
			}			
		}
		cleanGroupMemberCache(groupId);
		readyService.cacheGroupsInfo(userId);
		return row;
	}

	/**
	 * 主动申请加入群（目前自动加入）
	 * 
	 * @param userId
	 * @param destId
	 * @param destType
	 * @throws IOException 
	 */
	public ImGroup requestGroupJion(long userId, long destId, int destType) throws IOException {
		List<Map<String, Object>> groupMembers=this.getAllMemberFromCache(destId);
		if(groupMembers.size()>700){
			return null;
		}
		ImGroup group = (ImGroup) queryForObject("from ImGroup where id=?", destId);
		updateBySql("delete from im_group_member where userId=? and groupId=?", userId, destId);

		ImGroupMember member = new ImGroupMember();
		member.setCreateTime(System.currentTimeMillis());
		member.setCreatorId(userId);
		member.setUserId(userId);
		member.setRole(3);
		member.setIsAccept(1);
		member.setGroupId(destId);
		member.setReceiveTip(1);
		this.save(member);
		readyService.cacheGroupsInfo(userId);
		//通知群成员 
		for (Map<String, Object> users :groupMembers ) {
			long noticeUserId = Long.parseLong(users.get("userId").toString());
			if(noticeUserId!=userId){
				ImMessage msg = factory.joinedGroupNotice(userId, destId);
				chatService.storeMsgAndNotifyImServer(msg, noticeUserId);
			}			
		}
		this.cleanGroupMemberCache(destId);
		return group;
	}
	
	public void initTestGroup(String inviteId) throws IOException{
		this.inviteJoinGroup(inviteId, 2066l, 17070l);	
		}
	
	/**
	 * 邀请其它成员加入群
	 * @param inviteIds
	 * @param groupId
	 * @param userId
	 * @throws IOException
	 */
	public void inviteJoinGroup(String inviteIds,long groupId,long userId) throws IOException{
		Long[] userIds = YxUtil.splitLong(inviteIds);
		
		List<Map<String, Object>>  allMembers=this.getAllMemberFromCache(groupId);
		
		for (long memberId : userIds) {
			
			updateBySql("delete from im_group_member where groupId=? and userId=?", groupId,memberId);
			
			ImGroupMember member = new ImGroupMember();
			member.setCreateTime(System.currentTimeMillis());
			member.setCreatorId(userId);
			member.setUserId(memberId);
			member.setRole(3);
			member.setIsAccept(1);
			member.setGroupId(groupId);
			member.setReceiveTip(1);
			save(member);
			
			//通知被邀请人
			ImMessage msg = factory.inviteGroupNotice(memberId, groupId);
			chatService.storeMsgAndNotifyImServer(msg, memberId);
			
			//通知其它成员 
			for(Map<String, Object> otherMember:allMembers){
				long otherMemberId=Long.parseLong(otherMember.get("userId").toString());
				if(otherMemberId!=userId){
					ImMessage joinMsg = factory.joinedGroupNotice(memberId, groupId);
					chatService.storeMsgAndNotifyImServer(joinMsg, otherMemberId);
				}				
			}
		}
		this.cleanGroupMemberCache(groupId);
	}
	
	public int sendNoticeToMembers(long userId, long groupId, String content,Integer msgType) throws IOException {
		int row = 0;
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group != null) {
			row = 1;
			//通知为群组成员发送通知
			List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
			for(Map<String, Object> member:members){
				ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, content, msgType);
				chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
			}
		}
		return row;
	}

	// 发布群公告
	public Boolean createNote(String title,String content,Long userId,Long groupId)  throws IOException{
		
		if (userId==null||groupId==null) {
			return false;
		}
		ImGroupNote note = new ImGroupNote();
		note.setContent(content==null?"":content);
		note.setGroupId(groupId);
		note.setTitle(title==null?"":title);
		note.setUserId(userId);
		save(note);
		this.sendNoticeToMembers(userId, groupId, JSON.toJSON(note).toString(), ImConstants.MSG_TYPE_GROUP_NOTE_NEW);
		return true;
	}
	
	/**
	 * 获取群公告列表
	 * 
	 * @param userId
	 * @return
	 */
	public Page getNoteList(long userId,long groupId,int pageNo) {
		Page page= new Page();
		page.setPageNo(pageNo);
		page = this.queryForListBySql("select gn.* from im_group_note gn inner join im_group_member gm on gm.groupId=gn.groupId where gn.groupId = ? and gm.userId = "+userId+" order by gn.updateTime desc", page,groupId);
		return page;
	}
	
	
	
	public int updateGroupNote(long userId, long noteId, String content,String title) throws IOException {
		int row=0;
		ImGroupNote note = (ImGroupNote) this.queryForObject("from ImGroupNote where id=?", noteId);
		if (note==null) {
			return row;
		}
		if (title==null) {
			title=note.getTitle();
		}else {
			note.setTitle(title);
		}
		if (content==null) {
			content=note.getContent();
		}else{
			note.setContent(content);
		}
		row = this.updateBySql("update im_group_note set content=?,title =? where id=?", content,title, noteId);
		if (row>0) {
			this.sendNoticeToMembers(userId, note.getGroupId(), JSON.toJSON(note).toString(), ImConstants.MSG_TYPE_GROUP_NOTE_UPDATE);
		}
		return row;
	}
	
	public int delteGroupNote(long userId,long noteId){
		int row=0;
		ImGroupNote note = (ImGroupNote) this.queryForObject("from ImGroupNote where id=?", noteId);
		if (note==null) {
			return row;
		}
		row = this.updateBySql("delete from im_group_note where id=?", noteId);
		return row;
	}


	public ResponseData dismissGroup(long userId, long groupId) throws IOException {
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group!=null) {
			HashMap<String, Object> member=(HashMap<String, Object>) this.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
			if (member!=null) {
				Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
				if (role!=1) {
					return YxUtil.createFail("无权操作");
				}
				//通知为群组成员发送通知
				List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
				this.updateBySql("delete from im_group where id=? and createrId=?", groupId, userId);
				this.updateBySql("delete from im_group_member where groupId=?", groupId);
				HashMap<String, Object> content=new HashMap<>();
				content.put("groupId", groupId);
				content.put("groupName", group.getName());
				content.put("destId", userId);
				for(Map<String, Object> mem:members){
					if (Long.parseLong(mem.get("userId").toString())==userId) {
						continue;
					}
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_DISMISS);
					chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(mem.get("userId").toString()));				
				}
				readyService.cacheGroupsInfo(userId);
				//clean cache
				this.cleanGroupMemberCache(groupId);
				return YxUtil.createSimpleSuccess("操作成功");
			}
			return YxUtil.createFail("您不在该群组，无法操作");
		}
		return YxUtil.createFail("群已经解散");
	}
	
	public ResponseData transGroupRequest(long userId,long groupId,long destId)throws IOException{
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group!=null) {
			if (userId==destId) {
				return YxUtil.createFail("无法转让给自己");
			}
			ImGroupMember member=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", userId,groupId);
			ImGroupMember memberDest=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", destId,groupId);
			if (member!=null) {
				Integer role=member.getRole();
				if (role!=1) {
					return YxUtil.createFail("无权操作");
				}
				if (memberDest==null) {
					return YxUtil.createFail("请选择群组成员");
				}
				List row=this.createSQLQuery("select * from im_group_trans_log where status=0 and userId="+userId+" and groupId="+groupId+" and destId="+destId+";").list();
				if (row.size()>0) {
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", groupId);
					content.put("groupName", group.getName());
					content.put("destId", userId);
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_TRANS);
					chatService.storeMsgAndNotifyImServer(msg, destId);
					return YxUtil.createSimpleSuccess("发送请求成功");
				}
				SQLQuery query=this.createSQLQuery("insert into im_group_trans_log (userId,groupId,destId) values("+userId+","+groupId+","+destId+");");
				if (query.executeUpdate()>0) {
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", groupId);
					content.put("groupName", group.getName());
					content.put("destId", userId);
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_TRANS);
					chatService.storeMsgAndNotifyImServer(msg, destId);
					return YxUtil.createSimpleSuccess("发送请求成功");
				}
				return YxUtil.createFail("操作失败");
			}
			return YxUtil.createFail("您不在该群组，无法操作");
		}
		return YxUtil.createFail("群资料获取失败");
	}
	
	public ResponseData transGroupConfirm(long userId,long groupId,int accept) throws IOException{
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group!=null) {
			long destId=group.getCreaterId();
			ImGroupMember member=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", userId,groupId);
			ImGroupMember memberDest=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", destId,groupId);
			if (member!=null) {
				if (memberDest==null) {
					return YxUtil.createFail("群主信息获取失败");
				}
				List row=this.createSQLQuery("select * from im_group_trans_log where status=0 and userId="+destId+" and groupId="+groupId+" and destId="+userId+";").list();
				if (row.size()==0) {
					return YxUtil.createFail("操作已失效");
				}
				SQLQuery query=this.createSQLQuery("update im_group_trans_log set status="+accept+" where userId="+destId+" and destId="+userId+" and groupId="+groupId+";");
				if (query.executeUpdate()>0) {
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", groupId);
					content.put("groupName", group.getName());
					content.put("destId", userId);
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_TRANS_NO);
					if (accept==1) {
						group.setCreaterId(userId);
						member.setRole(1);
						memberDest.setRole(3);
						msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_TRANS_YES);
					}
					chatService.storeMsgAndNotifyImServer(msg, destId);
					return YxUtil.createSimpleSuccess("操作成功");
				}
				return YxUtil.createFail("操作失败");
			}
			return YxUtil.createFail("您不在该群组，无法操作");
		}
		return YxUtil.createFail("群资料获取失败");
	}
	
	public ResponseData setGroupAdmin(long userId,long groupId,long destId,int isSet) throws IOException{
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group!=null) {
			ImGroupMember member=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", userId,groupId);
			ImGroupMember memberDest=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", destId,groupId);
			if (member!=null) {
				Integer role=member.getRole();
				if (role!=1) {
					return YxUtil.createSimpleSuccess(ImConstants.RESPONSE_GROUP_2001,"无权操作");
				}
				if (memberDest==null) {
					return YxUtil.createSimpleSuccess(ImConstants.RESPONSE_GROUP_2003,"不是群组成员");
				}
				int r=(isSet==1?2:3);
				memberDest.setRole(r);
				save(memberDest);
				//通知为群组成员发送通知
				List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
				HashMap<String, Object> content=new HashMap<>();
				ImUser destUser=userService.getImUser(destId);
				content.put("name", destUser.getName());
				content.put("headUrl", destUser.getHeadUrl());
				content.put("role", r);
				for(Map<String, Object> mem:members){
					ImMessage msg = factory.modifyGroupNoticeCommon(destId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_ADMIN_SET);
					chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(mem.get("userId").toString()));				
				}
				return YxUtil.createSimpleSuccess("设置成功");
			}
			return YxUtil.createFail("设置失败");
		}
		return YxUtil.createSimpleSuccess(ImConstants.RESPONSE_GROUP_2000,"群资料获取失败");
	}
	
	
	public ResponseData updateGroupDescriptions(long userId, long groupId, String descriptions) throws IOException {
		ImGroup group = (ImGroup) this.queryForObject("from ImGroup where id=? ", groupId);
		if (group != null) {
			ImGroupMember mem=(ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", userId,groupId);
			Integer role=mem.getRole();
			if (role!=1) {
				return YxUtil.createSimpleSuccess(ImConstants.RESPONSE_GROUP_2001,"无权操作");
			}
			group.setDescriptions(descriptions);
			this.update(group);
			//通知群成员， 群简介被修改
			List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
			HashMap<String, Object> content=new HashMap<>();
			content.put("descriptions", descriptions);
			for(Map<String, Object> member:members){
				ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_DESCRIPTIONS);
				chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
			}
			return YxUtil.createSimpleSuccess("设置成功");
		}
		return YxUtil.createSimpleSuccess(ImConstants.RESPONSE_GROUP_2000,"群资料获取失败");
	}
	
	public Integer removeGroupMember(Long userId,long groupId,  long memberId) throws IOException{
		int row=0;
		ImGroupMember note = (ImGroupMember) this.queryForObject("from ImGroupMember where userId=? and groupId=?", memberId,groupId);
		if (note==null) {
			this.cleanGroupMemberCache(groupId);
			return row;
		}
		row = this.updateBySql("delete from im_group_member where groupId=? and userId=?", groupId,memberId);
		this.cleanGroupMemberCache(groupId);
		List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
		HashMap<String, Object> content=new HashMap<>();
		content.put("groupId", groupId);
		content.put("memberId", memberId);
		content.put("userId", userId);
		
		// 	通知用户他被删除了
		ImMessage msgNotice = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_MEMBER_REMOVE);
		chatService.storeMsgAndNotifyImServer(msgNotice, memberId);
		
		//通知群成员， 有人被删除了
		for(Map<String, Object> member:members){
			ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_MEMBER_REMOVE);
			chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
		}
				
		return row;
	}
	/**
	 * 更新加群权限
	 * @param groupId
	 * @param status
	 */
	public Integer updateGroupJoinStatus(long groupId,int status,String question,String answer,BigDecimal fee){
		int row=0;
		row = this.updateBySql("update im_group set joinStatus=?,question=?,answer=?,fee=? where id=?", status,question,answer,fee,groupId);
		return row;
	}
	
	/**
	 *申请加入群
	 * 
	 * @param userId
	 * @param destId
	 * @param destType
	 * @throws IOException 
	 * 
	 */
	public int requestGroupJionWithQuestion(long userId, long destId, String answer) throws IOException {
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=?", destId);
		
		List<Map<String, Object>> groupMembers=this.getAllMemberFromCache(destId);
		if((groupMembers.size()>=100&&group.getLevel()==0)||(groupMembers.size()>=200&&group.getLevel()==1)||(groupMembers.size()>=500&&group.getLevel()==2)||(groupMembers.size()>=1000&&group.getLevel()==3)||(groupMembers.size()>=2000&&group.getLevel()==4)){
			// 群人数到达上限
			return 5;
		}
		// 删除重复记录
		updateBySql("delete from im_group_member where userId=? and groupId=?", userId, destId);
		//	群人数校验完成
		ImGroupMember member = new ImGroupMember();
		member.setCreateTime(System.currentTimeMillis());
		member.setCreatorId(userId);
		member.setUserId(userId);
		member.setRole(3);
		member.setIsAccept(1);
		member.setGroupId(destId);
		member.setReceiveTip(1);
		if (group.getJoinStatus()==1||group.getJoinStatus()==2) {
			member.setIsAccept(0);
		}
		if ((group.getJoinStatus()==1||group.getJoinStatus()==2)&&(StringUtils.isBlank(answer))) {
			//  验证消息不能为空
			return 1;
		}
		if (group.getJoinStatus()==3&&(!answer.equals(group.getAnswer()))) {
			//  加群问题答案不正确
			return 2;
		}
		if (group.getJoinStatus()==4||group.getJoinStatus()==5) {
			//  不允许主动加入群组
			return 3;
		}
		if (group.getJoinStatus()==6&&!this.requestGroupCheck(userId, destId)) {
			//  没有付费
			return 4;
		}
		this.save(member);
		readyService.cacheGroupsInfo(userId);
		//	加入群组后
		if (member.getIsAccept()==1) {
			//通知群成员 
			for (Map<String, Object> users :groupMembers ) {
				long noticeUserId = Long.parseLong(users.get("userId").toString());
				if(noticeUserId!=userId){
					ImMessage msg = factory.joinedGroupNotice(userId, destId);
					chatService.storeMsgAndNotifyImServer(msg, noticeUserId);
				}			
			}
		}
		if (member.getIsAccept()==0) {
			//通知群主 和 管理员 有人申请加群
			for (Map<String, Object> users :groupMembers ) {
				long noticeUserId = Long.parseLong(users.get("userId").toString());
				Integer role = Integer.parseInt(users.get("role").toString());
				if (role==1||role==2) {
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", group.getId());
					content.put("groupName", group.getName());
					content.put("question", group.getQuestion());
					content.put("answer", group.getAnswer());
					content.put("userAnswer", answer);
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, group.getId(), JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_REQUEST);
					chatService.storeMsgAndNotifyImServer(msg, noticeUserId);
				}		
			}
		}
		
		this.cleanGroupMemberCache(destId);
		return 0;
	}
	//	加群支付校验
	private boolean requestGroupCheck(long userId,long groupId){
		return true;
	}
	
	public boolean checkGroupExits(long groupId){
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=?", groupId);
		if (group==null) {
			return false;
		}
		return true;
	}
	
	
	public ResponseData payForGroupJoin(Long userId,Long groupId,String pwd) throws IOException{
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=?", groupId);
		if (group==null) {
			return YxUtil.createFail("群不存在");
		}
		if (!payService.validatePayPwd(userId, pwd)) {
			return YxUtil.createSimpleSuccess(2, "支付密码不正确");
		}
		if (!walletService.validateBalance(userId, group.getFee())) {
			return YxUtil.createSimpleSuccess(3, "金额不足");
		}
		//  开始加群
		List<Map<String, Object>> groupMembers=this.getAllMemberFromCache(groupId);
		if((groupMembers.size()>=100&&group.getLevel()==0)||(groupMembers.size()>=200&&group.getLevel()==1)||(groupMembers.size()>=500&&group.getLevel()==2)||(groupMembers.size()>=1000&&group.getLevel()==3)||(groupMembers.size()>=2000&&group.getLevel()==4)){
			// 群人数到达上限
			return YxUtil.createFail("群组人数已达上限，无法加入");
		}
		// 删除重复记录
		updateBySql("delete from im_group_member where userId=? and groupId=?", userId, groupId);
		
		// 保存到交易记录
		ImWalletHistory walletHis = new ImWalletHistory();
		walletHis.setAmount(group.getFee());
		walletHis.setDestId(groupId);
		walletHis.setDestType(IMConstants.MSG_FROM_SYS);
		walletHis.setMoneyDirect(-1);
		walletHis.setMoneyType(WalletConstants.PAY_GROUP_JOIN);
		walletHis.setOccurTime(System.currentTimeMillis());
		walletHis.setUserId(userId);
		walletHis.setContent("付费加群");
		this.save(walletHis);

		// 更新wallet
		walletService.updateWallet(userId, group.getFee(), -1);
		//		群主到账
		// 保存到交易记录
		ImWalletHistory walletOwnHis = new ImWalletHistory();
		walletOwnHis.setAmount(group.getFee());
		walletOwnHis.setDestId(groupId);
		walletOwnHis.setDestType(IMConstants.MSG_FROM_SYS);
		walletOwnHis.setMoneyDirect(1);
		walletOwnHis.setMoneyType(WalletConstants.PAY_GROUP_JOIN);
		walletOwnHis.setOccurTime(System.currentTimeMillis());
		walletOwnHis.setUserId(group.getCreaterId());
		walletOwnHis.setContent("付费加群");
		this.save(walletOwnHis);	

		// 更新wallet
		walletService.updateWallet(group.getCreaterId(), group.getFee(), 1);	
		
		//	群人数校验完成
		ImGroupMember member = new ImGroupMember();
		member.setCreateTime(System.currentTimeMillis());
		member.setCreatorId(userId);
		member.setUserId(userId);
		member.setRole(3);
		member.setIsAccept(1);
		member.setGroupId(groupId);
		member.setReceiveTip(1);
		save(member);
		return YxUtil.createSimpleSuccess("加入成功");
	}
	
	/**
	 * 购买群组等级
	 * @param request
	 * @param response
	 * @param userId
	 * @param groupId
	 * @return
	 */
	public ResponseData payForGroupLevel(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long groupId,@RequestParam(defaultValue = "") String pwd,Integer level)  throws IOException{
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=? and createrId=?", groupId,userId);
		if (group==null) {
			return YxUtil.createSimpleSuccess(4, "只有群主可以升级");
		}
		if (!payService.validatePayPwd(userId, pwd)) {
			return YxUtil.createSimpleSuccess(2, "支付密码不正确");
		}
		ImGroupConfig config=(ImGroupConfig) queryForObject("from ImGroupConfig where level=?", level);
		if (config==null) {
			return YxUtil.createFail("服务器繁忙，请稍后重试");
		}
		BigDecimal amount=config.getFee();
		if (!walletService.validateBalance(userId, config.getFee())) {
			return YxUtil.createSimpleSuccess(3, "金额不足");
		}
		
		// 保存到交易记录
		ImWalletHistory walletHis = new ImWalletHistory();
		walletHis.setAmount(amount);
		walletHis.setDestId(groupId);
		walletHis.setDestType(IMConstants.MSG_FROM_SYS);
		walletHis.setMoneyDirect(-1);
		walletHis.setMoneyType(WalletConstants.PAY_GROUP_LEVEL);
		walletHis.setOccurTime(System.currentTimeMillis());
		walletHis.setUserId(userId);
		walletHis.setContent("购买群组等级");
		this.save(walletHis);
		
		// 更新wallet
		walletService.updateWallet(userId, amount, -1);
		
		// 升级群组
		group.setLevel(level);
		group.setExpire(System.currentTimeMillis()+config.getExpire()*1000);
		save(group);
		
		List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
		HashMap<String, Object> content=new HashMap<>();
		content.put("groupId", groupId);
		content.put("expire", group.getExpire());
		content.put("userId", userId);
		
		//通知群成员，群到期时间更新
		for(Map<String, Object> member:members){
			ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_UPDATE_EXPIRE);
			chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
		}
		return YxUtil.createSuccessData(group);
	}
	
	public ImGroupExtend groupInfo(Long groupId){
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=?", groupId);
		if (group==null) {
			return null;
		}
		return group;
	}
	/**
	 * 检测用户的收费群组是否到期 到期后发送续费通知
	 * @param userId
	 * @throws IOException 
	 */
	public void checkUserGroup(Long userId) throws IOException{
		List<Map<String, Object>> list = (List<Map<String, Object>>) queryForObjListBySql("select * from im_group where createrId=? and level>0 and expire<?", userId,System.currentTimeMillis());
		if (list!=null) {
			for (Map<String, Object> group : list) {
				HashMap<String, Object> content=new HashMap<>();
				content.put("groupId", group.get("id").toString());
				content.put("groupName", group.get("name").toString());
				content.put("expire", group.get("expire").toString());
				ImMessage msg = factory.modifyGroupNoticeCommon(userId, Long.parseLong(group.get("id").toString()), JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_EXPIRE);
				// 通知三天内发送
				if (Long.parseLong(group.get("expire").toString())>(System.currentTimeMillis()-3*24*60*60*1000)) {
					chatService.storeMsgAndNotifyImServer(msg, userId);
				}	
			}
		}
	}
	
	public List<ImGroupConfig> getGroupConfig(){
		List<ImGroupConfig>list=(List<ImGroupConfig>) queryForObjListBySql("select id as lid,level,expire,fee from im_group_config where level>? order by level asc",0);
		if (list!=null) {
			return list;
		}
		return null;
	}
	
	public ResponseData updateGroupMember(Long userId,Long groupId,Long destId,int type,int ope) throws IOException{
		if (userId>0&&groupId>0&&destId>0&&type>0) {
			ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=?", groupId);
			ImUser user=userService.getImUser(userId);
			if (type==1) {
				//	加群验证
				int row=0;
				if (ope==1) {
					row=this.updateGroupMemberField(destId, groupId, "isAccept", "1");
				}else{
					row=this.updateBySql("delete from im_group_member where userId=? and groupId=?", destId,groupId);
				}
				if (row>0) {
					// 开始发送验证成功通知
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", group.getId());
					content.put("groupName", group.getName());
					content.put("adminId", userId);
					content.put("adminName", user.getName());
					ImMessage msg = factory.modifyGroupNoticeCommon(userId, group.getId(), JSON.toJSONString(content), ope==1?ImConstants.NOTICE_OF_GROUP_REQUEST_YES:ImConstants.NOTICE_OF_GROUP_REQUEST_NO);
					chatService.storeMsgAndNotifyImServer(msg, destId);
					return YxUtil.createSimpleSuccess("操作成功");
				}
				return YxUtil.createFail("操作失败，请稍后重试");
			}else if (type==2) {
				//	禁言
				Long silenceTime=Long.parseLong(String.valueOf(ope));
				silenceTime=silenceTime==0?0:silenceTime*1000+System.currentTimeMillis();
				int row=0;
				row=this.updateBySql("update im_group_member set silence=? where groupId=? and userId=?", silenceTime,groupId,destId);
				if (row>0) {
					// 开始发送验证成功通知
					HashMap<String, Object> content=new HashMap<>();
					content.put("groupId", group.getId());
					content.put("groupName", group.getName());
					content.put("adminId", userId);
					content.put("adminName", user.getName());
					content.put("silenceTime", silenceTime);
					if (silenceTime==0) {
						ImMessage msg = factory.modifyGroupNoticeCommon(userId, group.getId(), JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_SILENCE_NO);
						chatService.storeMsgAndNotifyImServer(msg, destId);
						return YxUtil.createSimpleSuccess("取消禁言成功");
					}else{
						ImMessage msg = factory.modifyGroupNoticeCommon(userId, group.getId(), JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_SILENCE_YES);
						chatService.storeMsgAndNotifyImServer(msg, destId);
						return YxUtil.createSimpleSuccess("禁言成功");
					}
				}
				return YxUtil.createFail("操作失败，请稍后重试");
			}else {
				return YxUtil.createFail("网络繁忙，请稍后重试");
			}
		}
		return YxUtil.createFail("网络繁忙，请稍后重试");
	}
	
	/**
	 * 更新群成员信息
	 * @param userId
	 * @param destId
	 * @param groupId
	 * @param field
	 * @param value
	 * @return
	 */
	public int updateGroupMemberField(Long userId,Long groupId,String field,String value){
		int row=0;
		row = this.updateBySql("update im_group_member set "+field+"='"+value+"' where groupId=? and userId=?", groupId,userId);
		return row;
	}
	
	public ResponseData payForGroupExt(Long userId,Long groupId,String pwd) throws IOException{
		ImGroupExtend group = (ImGroupExtend) queryForObject("from ImGroupExtend where id=? and createrId=?", groupId,userId);
		if (group==null) {
			return YxUtil.createSimpleSuccess(4, "只有群主可以续费");
		}
		if (!payService.validatePayPwd(userId, pwd)) {
			return YxUtil.createSimpleSuccess(2, "支付密码不正确");
		}
		ImGroupConfig config=(ImGroupConfig) queryForObject("from ImGroupConfig where level=?", group.getLevel());
		if (config==null) {
			return YxUtil.createFail("服务器繁忙，请稍后重试");
		}
		BigDecimal amount=config.getFee();
		if (!walletService.validateBalance(userId, config.getFee())) {
			return YxUtil.createSimpleSuccess(3, "金额不足");
		}
		// 保存到交易记录
		ImWalletHistory walletHis = new ImWalletHistory();
		walletHis.setAmount(amount);
		walletHis.setDestId(groupId);
		walletHis.setDestType(IMConstants.MSG_FROM_SYS);
		walletHis.setMoneyDirect(-1);
		walletHis.setMoneyType(WalletConstants.PAY_GROUP_LEVEL_EXT);
		walletHis.setOccurTime(System.currentTimeMillis());
		walletHis.setUserId(userId);
		walletHis.setContent("群组等级续费");
		this.save(walletHis);
		
		// 更新wallet
		walletService.updateWallet(userId, amount, -1);
		
		// 群组续费
		group.setExpire(System.currentTimeMillis()+config.getExpire()*1000);
		save(group);
		
		List<Map<String, Object>> members=this.getAllMemberFromCache(groupId);
		HashMap<String, Object> content=new HashMap<>();
		content.put("groupId", groupId);
		content.put("expire", group.getExpire());
		content.put("userId", userId);
		
		//通知群成员，群到期时间更新
		for(Map<String, Object> member:members){
			ImMessage msg = factory.modifyGroupNoticeCommon(userId, groupId, JSON.toJSONString(content), ImConstants.NOTICE_OF_GROUP_UPDATE_EXPIRE);
			chatService.storeMsgAndNotifyImServer(msg, Long.parseLong(member.get("userId").toString()));
		}
		return YxUtil.createSuccessData(group);		
	}
}
