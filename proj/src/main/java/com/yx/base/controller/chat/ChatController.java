package com.yx.base.controller.chat;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils.Null;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONPObject;
import com.alibaba.fastjson.parser.Feature;
import com.alibaba.fastjson.serializer.SerializeFilter;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.framework.model.Page;
import com.framework.util.RedisUtil;
import com.framework.util.Utils;
import com.google.common.primitives.Longs;
import com.google.gson.JsonArray;
import com.opslab.util.RandomUtil;
import com.yx.base.extendmodel.ImGroupExtend;
import com.yx.base.extendmodel.ImUserContact;
import com.yx.base.extendmodel.ImUserReport;
import com.yx.base.model.ImGroup;
import com.yx.base.model.ImGroupMember;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImTop;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImUserPay;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.Constants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.CommonService;
import com.yx.base.service.chat.ChatConfig;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.feed.FeedService;
import com.yx.base.service.group.GroupService;
import com.yx.base.service.login.GroupThread;
import com.yx.base.service.login.LoginService;
import com.yx.base.service.login.ReadyService;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.message.MessageService;
import com.yx.base.service.redpacket.RedPacketService;
import com.yx.base.service.sms.SmsService;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.ImageTool;
import com.yx.base.util.ImageUtil;
import com.yx.base.nim.NimApi;
import com.yx.base.util.YxUtil;

import sun.tools.tree.ContinueStatement;

@RestController
@RequestMapping(value="/chat")
@CrossOrigin(origins ="*")
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ChatController {

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private ChatConfig config;
	
	@Autowired
	private ReadyService readyService;

	@Autowired
	private MsgStoreAndNotify chatService;
	
	@Autowired
	private LoginService loginService;

	@Autowired
	private UserService userService;

	@Autowired
	private GroupService groupService;

	@Autowired
	private SmsService smsService;

	@Autowired
	private MessageFactory msgFactory;
	

	@Autowired
	private MessageService msgService;
	
	@Autowired
	private RedPacketService redService;	
	
	@Autowired
	private FeedService feedService;
	
	@Autowired
	private WalletService walletService;

	@RequestMapping("/register")
	@ResponseBody
	public ResponseData register(HttpServletRequest request, HttpServletResponse response, String mobile, String pwd,
			String validateNum, @RequestParam(defaultValue = "") String headUrl,
			@RequestParam(defaultValue = "") String name,@RequestParam(defaultValue = "0")long recommandUserId) throws Exception {

		System.out.println(config.getLocal());
		if (!smsService.equalValidate(mobile, validateNum)) {
			return YxUtil.getResponse(3, "验证码不正确");
		}
		if (pwd==null||pwd.length()==0||validateNum==null||validateNum.length()==0) {
			return YxUtil.createFail("有参数不正确");
		}
		
		List list = commonService.queryForObjListBySql("select * from im_user where mobile=?", mobile);
		if (list != null && list.size() > 0) {
			return YxUtil.getResponse(2, "手机号码已存在");
		} else {
			ImUser user = new ImUser();
			if (name.length() == 0) {
				user.setName(mobile);
			} else {
				user.setName(name);
			}
			user.setPwd(Utils.toMd5(pwd));
			user.setMobile(mobile);
//			if(headUrl.length()==0){
//				String pathBack="/upload/"+RandomUtil.number(4)+System.currentTimeMillis()+".png";
//				String headFile=request.getServletContext().getRealPath("/")+pathBack;
//				ImageTool.createImage(user.getName().substring(0, 2), headFile);
//				String url = "http://" + config.getLocal() + request.getContextPath() + pathBack;
//				user.setHeadUrl(url);
//			}else{
				user.setHeadUrl(headUrl);
//			}
//			user.setIdNo(mobile.contains("+86")?mobile.replace("+86", ""):mobile);
			user.setIsOnline(0);
			user.setCreateTime(System.currentTimeMillis());
			user.setStatus(1);
			user.setNeedAuth(1);
			user.setNewNotification(0);
			user.setSearchMobile(1);
			user.setNickName(name);
			user.setIsAuth(0);
			user.setRecommandUserId(recommandUserId);
			commonService.save(user);
			userService.cacheUser(user);
			//测试使用
			userService.initBalance(user.getId());
			
			//初始好友
//			userService.initTestFriend(user.getId());
			
			//初始群
//			groupService.initTestGroup(String.valueOf(user.getId()));

			return YxUtil.createSuccessData(user);
		}
	}

	@RequestMapping("/createGroup")
	@ResponseBody
	public ResponseData createGroup(HttpServletRequest request, HttpServletResponse response, String name, Long userId,
			String ids) throws IOException {
		Long[] memberIds = YxUtil.splitLong(ids);

		if (name != null && userId != null) {
			ImGroup group = new ImGroup();
			group.setName(name);
			group.setCreaterId(userId);
			group.setCreateTime(System.currentTimeMillis());
			//group.setHeadUrl("http://" + chatService.getLocal() + "/wms/upload/group.png");
			commonService.save(group);

			// 添加群主到成员
			ImGroupMember member = new ImGroupMember();
			member.setCreateTime(System.currentTimeMillis());
			member.setCreatorId(userId);
			member.setGroupId(group.getId());
			member.setRole(1);
			member.setUserId(userId);
			member.setIsAccept(1);
			member.setReceiveTip(1);
			commonService.save(member);
			readyService.cacheGroupsInfo(userId);
			for (long memberId : memberIds) {
				
				ImMessage msg = msgFactory.inviteGroupNotice(memberId, group.getId());
				chatService.storeMsgAndNotifyImServer(msg, memberId);
			
				ImGroupMember members = new ImGroupMember();
				members.setCreateTime(System.currentTimeMillis());
				members.setCreatorId(userId);
				members.setGroupId(group.getId());
				members.setRole(3);
				members.setUserId(memberId);
				members.setIsAccept(1);
				members.setReceiveTip(1);
				commonService.save(members);
				readyService.cacheGroupsInfo(memberId);
			}
			Object o = commonService.queryForObjectBySql(
					"select b.id,b.name,a.receiveTip,headUrl from (select groupId,userId,receiveTip from im_group_member where userId=? and groupId=? and isaccept=1 group by groupId,userId,receiveTip) a LEFT JOIN im_group b on(a.groupId=b.id)",
					userId, group.getId());
			return YxUtil.createSuccessData(o);
		} else {
			return YxUtil.createFail("各参数不能为空");
		}

	}
	
	
	@RequestMapping("/updateGroupMemberMark")
	@ResponseBody
	public ResponseData updateGroupMemberMark(HttpServletRequest request, HttpServletResponse response, long userId, @RequestParam(defaultValue="0")long groupId,
			String markName) throws IOException {
		if(groupService.updateGroupMemberMark(userId, groupId, markName)>0){
			return YxUtil.createSimpleSuccess("更新成功");
		}
		return YxUtil.createFail("各参数不能为空");
	}
	
	
	@RequestMapping("/updateGroup")
	@ResponseBody
	public ResponseData updateGroup(HttpServletRequest request, HttpServletResponse response, long userId, @RequestParam(defaultValue="0")long groupId,
			String name) throws IOException {
		if(groupService.updateGroup(userId, groupId, name)>0){
			return YxUtil.createSimpleSuccess("更新成功");
		}

		return YxUtil.createFail("各参数不能为空");
	}
	
	
	@RequestMapping("/updateAuth")
	@ResponseBody
	public ResponseData updateAuth(HttpServletRequest request, HttpServletResponse response, long userId, String name,
			String validateNum,String idNo,String mobile) throws IOException {
		int status=userService.checkIdNo(userId, idNo);
		if (status==2) {
			return YxUtil.createSimpleSuccess(2, "身份证已被使用");
		}
		if (status==0) {
			return YxUtil.createSimpleSuccess(0,"认证审核中");
		}
		if (status==1) {
			return YxUtil.createSimpleSuccess("认证成功");
		}
		if(userService.updateAuth(userId, name, validateNum, idNo, mobile)>0){
			return YxUtil.createSimpleSuccess("提交成功，请等待审核");
		}

		return YxUtil.createFail("各参数不能为空");
	}
	

	@RequestMapping("/updatePrivateSetting")
	@ResponseBody
	public ResponseData updatePrivateSetting(HttpServletRequest request, HttpServletResponse response, int needAuth,
			int newNotification, int searchMobile, long userId) throws IOException {

		ImUser setting = (ImUser) userService.getImUser(userId);
		setting.setNeedAuth(needAuth);
		setting.setNewNotification(newNotification);
		setting.setSearchMobile(searchMobile);

		commonService.update(setting);
		return YxUtil.createSimpleSuccess("更新成功");
	}

	@RequestMapping("/setIgonre")
	@ResponseBody
	public ResponseData setIgonre(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") int receiveTip, @RequestParam(defaultValue = "0") long destId,
			int destType, long userId) throws IOException {
		if (destType == 1) {
			commonService.updateBySql("update im_friend set receiveTip=? where userId=? and friendId=?", receiveTip,
					userId, destId);
		} else {
			commonService.updateBySql("update im_group_member set receiveTip=? where userId=? and groupId=?",
					receiveTip, userId, destId);
		}
		readyService.cacheFriendInfo(userId);
		readyService.cacheGroupsInfo(userId);
		
		readyService.cacheFriendInfo(destId);
		readyService.cacheGroupsInfo(destId);
		return YxUtil.createSimpleSuccess("设置成功");
	}

	@RequestMapping("/doLogin")
	@ResponseBody
	public ResponseData doLogin(HttpServletRequest request, HttpServletResponse response, String mobile, String pwd,@RequestParam(defaultValue="0")int device,@RequestParam(defaultValue="0")String versionType,@RequestParam(defaultValue="+86")String code,@RequestParam(defaultValue="")String UUID) {		
		if(device==0){
			return YxUtil.createFail("老用户拒绝登陆");
		}
		return userService.doLogin(mobile, pwd,request,device,code,UUID);
	}

	@RequestMapping("/findPwd")
	@ResponseBody
	public ResponseData findPwd(HttpServletRequest request, HttpServletResponse response, String mobile, String pwd,
			String validateNum) {
		if (!smsService.equalValidate(mobile, validateNum)) {
			return YxUtil.createFail("验证码不正确");
		}
		ImUser user = (ImUser) commonService.queryForObject("from ImUser where mobile=? ", mobile);
		if (user != null) {
			user.setPwd(Utils.toMd5(pwd));
			commonService.update(user);
			return YxUtil.createSuccessData(user);
		} else {
			return YxUtil.createFail("操作失败");
		}
	}

	@RequestMapping("/updateHead")
	@ResponseBody
	public ResponseData updateHead(HttpServletRequest request, long userId, String headUrl) {
		try {
			ImUser user = (ImUser) userService.getImUser(userId);
			if (user != null) {
				user.setHeadUrl(headUrl);
				commonService.update(user);
				userService.cacheUser(user);
				feedService.updateFeed(userId, "", headUrl);
			}
			return YxUtil.createSimpleSuccess("头像更新完成");
		} catch (Exception e) {
			e.printStackTrace();
			return YxUtil.createFail("更新失败");
		}
	}

	@RequestMapping("/doUploads")
	@ResponseBody
	public ResponseData doUploads(HttpServletRequest request, String fileExt) {
		try {
			byte file[] = Utils.getByteByStream(request.getInputStream(), request.getContentLength());
			String headUrl = "/upload/" + System.currentTimeMillis() + "." + fileExt;
			String realPath = request.getSession().getServletContext().getRealPath("/");
			System.out.println("文件保存的地址：" + realPath);
			Utils.writeFile(file, realPath + headUrl);
			String url = "http://" + config.getLocal() + headUrl;
			return YxUtil.createSimpleSuccess(url);
		} catch (Exception e) {
			e.printStackTrace();

			return YxUtil.createFail("上传失败");
		}
	}

	@SuppressWarnings("deprecation")
	@RequestMapping("/uploadImage")
	@ResponseBody
	public ResponseData uploadImage(HttpServletRequest request, @RequestParam CommonsMultipartFile[] fileUpload,
			ModelMap model) throws Exception {
		String realPath = request.getSession().getServletContext().getRealPath("/upload");
		List fileList = new ArrayList();
		String fileName = "";
		if (fileUpload != null && fileUpload.length > 0) {
			for (CommonsMultipartFile aFile : fileUpload) {
				double size=aFile.getBytes().length/1024d;
				boolean isImage=false;
				String srcName=aFile.getOriginalFilename().toLowerCase();
				if(srcName.contains(".png")||srcName.contains(".jpg")||srcName.contains(".jpeg")){
					isImage=true;
				}				
				fileName =  System.currentTimeMillis() + "_" + Utils.random(6)+srcName;
				if (!aFile.getOriginalFilename().equals("")) {
					aFile.transferTo(new File(realPath + "/"  + fileName));
					if(size>1000&&isImage){						
						ImageUtil.scaleResize(realPath+"/"+fileName, realPath + "/small_" + fileName, 400, null);
						fileName="small_"+fileName;
					}
					fileList.add("http://" + config.getLocal() + request.getContextPath() +"/upload/"+ fileName);
				}
			}
		}

		return YxUtil.createSimpleSuccess(fileList);
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/pcuploadImage")
	@ResponseBody
	public ResponseData pcuploadImage(HttpServletRequest request, @RequestParam CommonsMultipartFile[] fileUpload,
			ModelMap model) throws Exception {
		String realPath = request.getSession().getServletContext().getRealPath("/upload");
		List fileList = new ArrayList();
		String fileName = "";
		if (fileUpload != null && fileUpload.length > 0) {
			for (CommonsMultipartFile aFile : fileUpload) {
				double size=aFile.getBytes().length/1024d;
				HashMap<String,Object> fileMap=new HashMap<String,Object>();
				boolean isImage=false;
				String srcName=aFile.getOriginalFilename().toLowerCase();
				if(srcName.contains(".png")||srcName.contains(".jpg")||srcName.contains(".jpeg")){
					isImage=true;
				}
				fileMap.put("fileSize", size);
				fileMap.put("fileName", srcName);
				fileName = System.currentTimeMillis() + "_" + Utils.random(6)+srcName.substring(srcName.lastIndexOf("."));
				if (!aFile.getOriginalFilename().equals("")) {
					aFile.transferTo(new File(realPath + "/"  +fileName));
					if(size>1000&&isImage){						
						ImageUtil.scaleResize(realPath+"/"+fileName, realPath + "/small_" + fileName, 400, null);
						fileName="small_"+fileName;
					}
					fileMap.put("fileUrl", "http://" + config.getLocal() + request.getContextPath() +"/upload/"+ fileName);
					fileList.add(fileMap);
				}
			}
		}

		return YxUtil.createSuccessData(fileList);
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping("/uploadImageJsonp")
	@ResponseBody
	public JSONPObject uploadImageJsonp(HttpServletRequest request, @RequestParam CommonsMultipartFile[] fileUpload,
			ModelMap model) throws Exception {
		List fileList = new ArrayList();
		String fileName = "";
		if (fileUpload != null && fileUpload.length > 0) {
			for (CommonsMultipartFile aFile : fileUpload) {
				fileName = "/upload/" + System.currentTimeMillis() + "_" + aFile.getOriginalFilename();
				if (!aFile.getOriginalFilename().equals("")) {
					aFile.transferTo(new File(request.getRealPath("/") + fileName));
					System.out.println("http://" + config.getLocal() + request.getContextPath() + fileName);
					fileList.add("http://" + config.getLocal() + request.getContextPath() + fileName);
				}
			}
		}
		JSONPObject jsonp = new JSONPObject("jsonpcallback");
		jsonp.addParameter(YxUtil.createSimpleSuccess(fileList));
		return jsonp;
	}

	@RequestMapping("/getValidateNum")
	@ResponseBody
	public ResponseData getValidateNum(HttpServletRequest request, HttpServletResponse response, String mobile,@RequestParam(defaultValue="samim")String app) {
		String validateNum = Utils.randomInt(4);
			
//		测试时候;
		Integer integer=0;
		RedisUtil.expired(Constants.SMS_KEY.getBytes(), 60 * 30);
		RedisUtil.hset(Constants.SMS_KEY, mobile, validateNum);
		
//		return YxUtil.createSimpleSuccess(validateNum);
		//     正式
//		Integer integer;
		RedisUtil.expired(Constants.SMS_KEY.getBytes(), 60 * 30);
		RedisUtil.hset(Constants.SMS_KEY, mobile, validateNum);
		if (app.equals(new String("samim"))) {
			integer=smsService.sendSms(mobile, validateNum);
		}else{
			integer=smsService.sendSms(mobile, validateNum,app);
		}
		//		正式结束
		String mString="短信发送失败，请稍后重试";
		switch (integer) {
		case 2:
			mString="手机号格式不正确";
			break;
		case 22:
			mString="1小时内只能获取3次验证码";
			break;
		case 33:
			mString="30秒内只能获取1次验证码";
			break;
		case 20:
			mString="不支持该地区";
			break;
		case 43:
			mString="今日验证码次数已达到上限";
			break;
		case 3:
			mString="发送失败，请联系客服ErrCode=3";
			break;
		default:
			break;
		}
		if(integer==0){
			return YxUtil.createSimpleSuccess(validateNum);
		}else{
			return YxUtil.createFail(mString);
		}
	}

	@RequestMapping("/queryUser")
	@ResponseBody
	public ResponseData queryUser(HttpServletRequest request, HttpServletResponse response, String mobile,
			long userId) {
//		List list = commonService.queryForObjListBySql(
//				"select id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,createTime,status,detail,headUrl,imNumber as IMNo from im_user where (mobile like '%"
//						+ mobile + "%' or imNumber like '%"
//						+ mobile + "%') and searchMobile=1 limit 0,20");
		List list = commonService.queryForObjListBySql(
				"select id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,createTime,status,detail,headUrl,imNumber as IMNo from im_user where (mobile like '%"
						+ mobile + "%' or id = '"
						+ mobile + "') and searchMobile=1 limit 0,20");
		return YxUtil.createSimpleSuccess(list);
	}

	@RequestMapping("/getGroupMember")
	@ResponseBody
	public ResponseData getGroupMember(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue="0")long groupId,
			long userId,@RequestParam(defaultValue="0")String version) throws IOException {
		/*if(version==0){
			System.out.println("老版本查询群成员 ");
			return YxUtil.createFail("error query.");
		}*/
		List list = null;
		list = groupService.getAllMemberFromCache(groupId);
		return YxUtil.createSimpleSuccess(list);
	}

	@RequestMapping("/addGroupMember")
	@ResponseBody
	public ResponseData addGroupMember(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue="0")long groupId,
			long userId, String inviteIds) throws IOException {
		groupService.inviteJoinGroup(inviteIds, groupId, userId);		
		return YxUtil.createSimpleSuccess("邀请完成");
	}

	@RequestMapping("/getMsgHistory")
	@ResponseBody
	public ResponseData getMsgHistory(HttpServletRequest request, HttpServletResponse response, long destId,
			long destType, @RequestParam(defaultValue = "20") int size,
			@RequestParam(defaultValue = "0") long sendTime, long userId) {

		List list = msgService.getHistory(destId, destType, size, sendTime, userId);
		return YxUtil.createSimpleSuccess(list);
	}

	@RequestMapping("/setBlock")
	@ResponseBody
	public ResponseData setBlock(HttpServletRequest request, HttpServletResponse response, long blockId, long userId) throws IOException {
		commonService.updateBySql("update im_friend set isBlack=1 where userId=? and friendId=?", userId, blockId);
		readyService.cacheFriendInfo(userId);
		return YxUtil.createSimpleSuccess("设置成功");
	}

	@RequestMapping("/queryGroup")
	@ResponseBody
	public ResponseData queryGroup(HttpServletRequest request, HttpServletResponse response, String groupName,
			long userId) {
		List list = null;
		list = commonService.queryForObjListBySql("select * from im_group where name like '%" + groupName + "%' or id= '" + groupName + "' limit 0,20");
		return YxUtil.createSimpleSuccess(list);
	}

	@RequestMapping("/setTop")
	@ResponseBody
	public ResponseData setTop(HttpServletRequest request, HttpServletResponse response, long destId, long userId,
			int destType) throws IOException {
		if (destType > 0 && userId > 0 && destId > 0) {
			commonService.updateBySql("delete from im_top where userId=? and destId=? and destType=?", userId, destId,
					destType);
			ImTop top = new ImTop();
			top.setDestId(destId);
			top.setDestType(destType);
			top.setUserId(userId);
			commonService.save(top);
			readyService.cacheTopList(userId);
		}

		return YxUtil.createSimpleSuccess("设置成功");
	}
	
	@RequestMapping("/cancleTop")
	@ResponseBody
	public ResponseData cancleTop(HttpServletRequest request, HttpServletResponse response, long destId, long userId,
			int destType) {
		if (destType > 0 && userId > 0 && destId > 0) {
			commonService.updateBySql("delete from im_top where userId=? and destId=? and destType=?", userId, destId,
					destType);
		}
		return YxUtil.createSimpleSuccess("设置成功");
	}
	
	
	@RequestMapping("/getGroupById")
	@ResponseBody
	public ResponseData getGroupById(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue="0")long groupId, long userId) {
		if ( userId > 0 && userId > 0) {
			ImGroupExtend groupExtend=groupService.groupInfo(groupId);
			if (groupExtend==null) {
				return YxUtil.createFail("群不存在");
			}
			return YxUtil.createSuccessData(groupExtend);
		}

		return YxUtil.createFail("参数错误，请稍后重试");
		
	}
	
	

	@RequestMapping("/updateRemark")
	@ResponseBody
	public ResponseData updateRemark(HttpServletRequest request, HttpServletResponse response, long destId, long userId,
			String remark) throws IOException {
		if (destId > 0 && userId > 0) {
			commonService.updateBySql("update im_friend set remark=? where userId=? and friendId=?", remark, userId,
					destId);
		}
		readyService.cacheFriendInfo(userId);
		return YxUtil.createSimpleSuccess("设置成功");
	}

	@RequestMapping("/quitGroup")
	@ResponseBody
	public ResponseData quitGroup(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue="0")long groupId, long userId) throws IOException {
		if (groupId > 0 && userId > 0) {
			groupService.updateQuitGroup(groupId, userId);
			return YxUtil.createSimpleSuccess("退出成功");
		}
		return YxUtil.createFail("退出失败");

	}

	@RequestMapping("/removeBlack")
	@ResponseBody
	public ResponseData removeBlack(HttpServletRequest request, HttpServletResponse response, long destId,
			long userId) throws IOException {
		if (destId > 0 && userId > 0) {
			userService.removeBlack(userId, destId);
		}

		return YxUtil.createSimpleSuccess("移出成功");
	}

	@RequestMapping("/getBlackList")
	@ResponseBody
	public ResponseData getBlackList(HttpServletRequest request, HttpServletResponse response, long userId) {
		if (userId > 0) {
			return YxUtil.createSuccessData(userService.getBlackList(userId));
		}

		return YxUtil.createFail("获取失败");
	}
	
	@RequestMapping("/delFriend")
	@ResponseBody
	public ResponseData delFriend(HttpServletRequest request, HttpServletResponse response, long userId,long destId) throws IOException {
		if (userId > 0) {
			userService.delUser(userId, destId);
			return YxUtil.createSimpleSuccess("操作成功");
		}

		return YxUtil.createFail("获取失败");
	}

	@RequestMapping("/sendRedPacket")
	@ResponseBody
	public ResponseData sendRedPacket(HttpServletRequest request, HttpServletResponse response, int redPacketCount,
			long userId, BigDecimal redPacketAmount, int destType, long destId, int redPacketType,@RequestParam(defaultValue="恭喜发财")String redPacketContent,@RequestParam(defaultValue="")String command,@RequestParam(defaultValue="")String limit) throws IOException {
		if (redPacketType > 0 && destId > 0 && redPacketCount > 0&&redPacketCount<20000 && userId > 0  && destType > 0) {
			long id=redService.createRedPacket(redPacketCount, userId, redPacketAmount, destType, destId, redPacketType,redPacketContent,command,limit);
			if(id>0){
				return YxUtil.createSuccessData(id);
			}			
		}
		return YxUtil.createFail("红包发送失败");
	}
	
	@RequestMapping("/openRedPacket")
	@ResponseBody
	public ResponseData openRedPacket(HttpServletRequest request, HttpServletResponse response, long userId, long redPacketId) throws IOException {
		if (redService.checkOpenLimit(redPacketId, userId)==1) {
			return YxUtil.createSimpleSuccess(5, "红包不存在");
		}else if (redService.checkOpenLimit(redPacketId, userId)==-1) {
			return YxUtil.createSimpleSuccess(4, "您不在指定对象中，无法开启");
		}
		List list=commonService.queryForObjListBySql("select * from im_redpacket_history where userId=? and redPacketId=?", userId,redPacketId);
		if(list!=null&&list.size()>0){			
			return YxUtil.createSimpleSuccess(2, "你已经领取过");
		}
		
		if (redPacketId > 0 && userId > 0 ) {
			String amount=redService.updateRedPacket(redPacketId, userId);
			if(amount!=null){
				return YxUtil.createSuccessData(amount);
			}else{
				return YxUtil.createSimpleSuccess(3, "已经被领完");
			}
		}

		return YxUtil.createFail("发生异常领取失败");
	}
	
	@RequestMapping("/getRedPacketHistory")
	@ResponseBody
	public ResponseData getRedPacketHistory(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(defaultValue="0")long userId, long redPacketId) {
		if (userId > 0 && redPacketId > 0 ) {
			HashMap<String, Object> map=redService.getRedPacketHistory(redPacketId,userId);
			return YxUtil.createSuccessData(map);
		}

		return YxUtil.createFail("发生查看红包历史异常");
	}
	
	
	
	@RequestMapping("/getUserById")
	@ResponseBody
	public ResponseData getUserById(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(defaultValue="0")long userId, long destId) throws IOException {
		if (userId > 0 && destId > 0 ) {
			ImUser user=userService.getImUser(destId);
			HashMap<String, Object> data=new HashMap<>();
			data.putAll(JSON.parseObject(JSON.toJSONString(user, SerializerFeature.WriteNullStringAsEmpty)));
			HashMap<String, Object> number=(HashMap<String, Object>) commonService.queryForObjectBySql("select imNumber as IMNo from im_user where id=?", destId);
			if (data!=null) {
				data.put("pwd", "");
				data.putAll(feedService.getFeedAuth(userId, destId));
				data.putAll(number);
				return YxUtil.createSuccessData(data);
			}
//			if(user!=null){
//				user.setPwd("");
//				return YxUtil.createSuccessData(user);
//			}
		}
		return YxUtil.createFail("发生异常");
	}
	

	@RequestMapping("/requestFriend")
	@ResponseBody
	public ResponseData requestFriend(HttpServletRequest request, HttpServletResponse response, int destType,
			long userId, long destId) throws IOException {
		// 如果 是人，
		if (destType == IMConstants.MSG_FROM_P2P) {
			int code=userService.requestFriend(destType, userId, destId);
			HashMap map=new HashMap();
			map.put("info", "完成");
			return YxUtil.getResponse(code, map);
		}
		if(IMConstants.MSG_FROM_GROUP==destType){
			//如果是群
			ImGroup group=groupService.requestGroupJion(userId, destId, destType);
			if(group==null){
				return YxUtil.createFail("加入群失败，可能超过人数限制700");
			}
			return YxUtil.createSuccessData(group);
		}
		return YxUtil.createFail("可能参数不对");
	}

	@RequestMapping("/acceptRequest")
	@ResponseBody
	public ResponseData acceptRequest(HttpServletRequest request, HttpServletResponse response, int destType,
			long userId, long destId, @RequestParam(defaultValue = "0") long groupId) throws IOException {

		if (destType == 1) {
			ImMessage msg = msgFactory.acceptFriendNotice(userId, destId);
			chatService.storeMsgAndNotifyImServer(msg, destId);

			commonService.updateBySql("update im_friend set isFriend=1 where userId=? and friendId=?", userId, destId);
			commonService.updateBySql("update im_friend set isFriend=1 where userId=? and friendId=?", destId, userId);
			
			ImUser user=userService.getImUser(destId);
			user.setPwd("");
			
			readyService.cacheFriendInfo(userId);
			readyService.cacheFriendInfo(destId);
			RedisUtil.sadd(("friends_"+userId).getBytes(), Longs.toByteArray(destId));
			RedisUtil.sadd(("friends_"+destId).getBytes(), Longs.toByteArray(userId));
			return YxUtil.createSuccessData(user);
		}

		return YxUtil.createFail("加好友失败");
	}

	@RequestMapping("/updateProfile")
	@ResponseBody
	public ResponseData updateProfile(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") String userId, String nickName,String city, String province, String name, String sign,
			String sex, String district) throws IOException {
			ImUser user=userService.updateProfile(userId, nickName, city, province, name, sign, sex, district);
			if(user!=null){
				user.setPwd("");
				return YxUtil.createSuccessData(user);
			}
		return YxUtil.createFail("更新失败");
	}

	@RequestMapping("/ready")
	@ResponseBody
	public ResponseData ready(HttpServletRequest request, HttpServletResponse response, String token) throws IOException {
		HashMap<String, Object> data = new HashMap<String, Object>();
		String tokenDecrypt = Utils.decrypt(token);
		System.out.println(tokenDecrypt);
		long userId = Long.parseLong(tokenDecrypt);

		ImUser my = (ImUser) userService.getImUser(userId);
		if (my != null) {
			my.setPwd("");
		}
		ImUserPay payInfo=readyService.getImUserPay(userId);
		
		data.put("topList", readyService.getTopList(userId));
		HashMap<String, Object> info=new HashMap<>();
		info=(HashMap<String, Object>) JSON.parseObject(JSON.toJSONString(my, SerializerFeature.WriteNullStringAsEmpty), Map.class);
		HashMap<String, Object> user=(HashMap<String, Object>) commonService.queryForObjectBySql("select imNumber from im_user where id=?", userId);
		info.put("IMNo", user.get("imNumber")!=null?user.get("imNumber"):"");
		data.put("myInfo", info);
		data.put("friendsInfo", readyService.getFriendInfo(userId));
		data.put("groupsInfo", readyService.getGroupsInfo(userId));
		data.put("friends", commonService.getUserFriends(userId));
		data.put("payInfo", payInfo!=null?payInfo.getPayPwd():"");
		walletService.initWallet(userId);
		//	群组到期检测线程
//		new GroupThread(userId).run();
		try {
			groupService.checkUserGroup(userId);
		} catch (Exception e) {
			return YxUtil.createSuccessData(data);
		}
		return YxUtil.createSuccessData(data);
	}
	
	@RequestMapping("/setGroupHeader")
	@ResponseBody
	public ResponseData setGroupHeader(HttpServletRequest request,HttpServletResponse response,long userId,long groupId,String url) throws IOException{
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
//			return YxUtil.createFail("无权操作"+role+"or"+member.get("role").toString());
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			commonService.updateBySql("update im_group set headUrl=? where id=?", url, groupId);
			readyService.cacheGroupsInfo(userId);
			groupService.sendNoticeToMembers(userId, groupId, url, ImConstants.MSG_TYPE_GROUP_HEAD);
			return YxUtil.createSimpleSuccess("操作成功");
		}
		return YxUtil.createFail("设置失败");
	}
	
	@RequestMapping("/createGroupNote")
	@ResponseBody
	public ResponseData createGroupNote(HttpServletRequest request,HttpServletResponse response,Long userId,Long groupId,String content,String title) throws IOException{
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
//			return YxUtil.createFail("无权操作"+role+"or"+member.get("role").toString());
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			if (groupService.createNote(title, content, userId, groupId)) {
				return YxUtil.createSimpleSuccess("操作成功");
			}
			return YxUtil.createFail("发布失败");
		}
		return YxUtil.createFail("您不在该群组，无法操作");
	}
	
	@RequestMapping("/getNoteList")
	@ResponseBody
	public ResponseData getNoteList(HttpServletRequest request, HttpServletResponse response, long userId,long groupId,@RequestParam(defaultValue="1")int pageNo) {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
			Integer editable=0;
			if (role==1||role==2) {
				editable=1;
			}
			Page page =groupService.getNoteList(userId, groupId,pageNo);
			HashMap<String, Object> data =new HashMap<String,Object>();
			data.put("list", page.getList());
			data.put("pageNo", page.getPageNo());
			data.put("pageSize", page.getPageSize());
			data.put("totalCount", page.getTotalCount());
			data.put("orderBy", page.getOrderBy());
			data.put("orderType", page.getOrderType());
			data.put("totalPage", page.getTotalPage());
			data.put("editable", editable);
			return YxUtil.createSuccessData(data);
		}
		return YxUtil.createFail("您不在该群组，无法操作");
	}
	
	@RequestMapping("/updateGroupNote")
	@ResponseBody
	public ResponseData updateGroupNote(HttpServletRequest request, HttpServletResponse response, long userId, @RequestParam(defaultValue="0")long groupId, @RequestParam(defaultValue="0")long noteId,
			String content,String title) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
//			return YxUtil.createFail("无权操作"+role+"or"+member.get("role").toString());
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			if(groupService.updateGroupNote(userId, noteId, content, title)>0){
				return YxUtil.createSimpleSuccess("更新成功");
			}
			return YxUtil.createFail("各参数不能为空");
		}
		return YxUtil.createFail("您不在该群组，无法操作");
		
	}
	
	@RequestMapping("/deleteGroupNote")
	@ResponseBody
	public ResponseData deleteGroupNote(HttpServletRequest request, HttpServletResponse response, long userId, @RequestParam(defaultValue="0")long groupId, @RequestParam(defaultValue="0")long noteId) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
//			return YxUtil.createFail("无权操作"+role+"or"+member.get("role").toString());
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			if(groupService.delteGroupNote(userId, noteId)>0){
				return YxUtil.createSimpleSuccess("删除成功");
			}
			return YxUtil.createFail("删除失败");
		}
		return YxUtil.createFail("您不在该群组，无法操作");
		
	}
	
	@RequestMapping("/inviteContact")
	@ResponseBody
	public ResponseData inviteContact(HttpServletRequest request, HttpServletResponse response, long userId, @RequestParam(defaultValue = "") String contact) throws IOException {
		HashMap<String, Object> data =new HashMap<>();
		if (contact==null||StringUtils.isBlank(contact)) {
			data.put("info", userService.myContact(userId));
			return YxUtil.createSuccessData(data);
		}
		userService.importContact(userId, contact);
		data.put("info", userService.myContact(userId));
		return YxUtil.createSuccessData(data);
//		return YxUtil.createSimpleSuccess("导入完成，成功导入"+success+"条数据");
		
	}
	
	@RequestMapping("/myContact")
	@ResponseBody
	public ResponseData myContact(HttpServletRequest request, HttpServletResponse response, long userId,String contact,@RequestParam(defaultValue = "1") int pageNo) throws IOException {
		
		if (contact==null||StringUtils.isBlank(contact)) {
			return YxUtil.createSuccessData(userService.getContacts(userId, contact, pageNo));
		}
		return YxUtil.createSuccessData(userService.getContacts(userId, contact, pageNo));
//		return YxUtil.createSimpleSuccess("导入完成，成功导入"+success+"条数据");
		
	}
	
	
	@RequestMapping("/report")
	@ResponseBody
	public ResponseData report(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long destId,@RequestParam(defaultValue = "0")int destType,@RequestParam(defaultValue = "")String imgs,@RequestParam(defaultValue = "") String msg) throws IOException {
		if (userId>0&&destId>0) {
			ImUserReport report=userService.report(userId, destId, destType, imgs, msg);
			return YxUtil.createSuccessData(report);
		}
		return YxUtil.createFail("举报发送失败");
		
	}
	
	@RequestMapping("/dismissGroup")
	@ResponseBody
	public ResponseData dismissGroup(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId) throws IOException {
		if (userId>0&&groupId>0) {
			return groupService.dismissGroup(userId, groupId);
		}
		return YxUtil.createFail("操作失败");
		
	}
	
	@RequestMapping("/transGroup")
	@ResponseBody
	public ResponseData transGroup(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "0")long destId) throws IOException {
		if (userId>0&&groupId>0&&destId>0) {
			return groupService.transGroupRequest(userId, groupId, destId);
		}
		return YxUtil.createFail("操作失败");
		
	}
	
	@RequestMapping("/transGroupConfirm")
	@ResponseBody
	public ResponseData transGroupConfirm(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "0")long destId,@RequestParam(defaultValue = "2")int accept) throws IOException {
		if (userId>0&&groupId>0) {
			return groupService.transGroupConfirm(userId, groupId, accept);
		}
		return YxUtil.createFail("操作失败");
		
	}
	
	@RequestMapping("/setGroupAdmin")
	@ResponseBody
	public ResponseData setGroupAdmin(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "0")long destId,@RequestParam(defaultValue = "1")int isSet) throws IOException {
		if (userId>0&&groupId>0) {
			return groupService.setGroupAdmin(userId, groupId, destId,isSet);
		}
		return YxUtil.createFail("操作失败");
		
	}
	
	
	@RequestMapping("/updateGroupDesc")
	@ResponseBody
	public ResponseData updateGroupDesc(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "")String descriptions) throws IOException {
		if (userId>0&&groupId>0) {
			return groupService.updateGroupDescriptions(userId, groupId, descriptions);
		}
		return YxUtil.createFail("操作失败");
		
	}
	
	
	@RequestMapping("/removeGroupMember")
	@ResponseBody
	public ResponseData removeGroupMember(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "0")long destId) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			if(groupService.removeGroupMember(userId,groupId, destId)>0){
				return YxUtil.createSimpleSuccess("删除成功");
			}
			return YxUtil.createFail("删除失败");
		}
		return YxUtil.createFail("您不在该群组，无法操作");
		
	}
	
	
	@RequestMapping("/updateJoinstatus")
	@ResponseBody
	public ResponseData updateJoinstatus(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "0")int status,@RequestParam(defaultValue = "")String question,@RequestParam(defaultValue = "")String answer,@RequestParam(defaultValue = "0.00") BigDecimal fee) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			if (status<0||status>6) {
				return YxUtil.createFail("网络繁忙，请稍后重试");
			}
			if (status==2&&StringUtils.isBlank(question)) {
				return YxUtil.createFail("请配置正确的验证问题");
			}
			if (status==3&&(StringUtils.isBlank(question)||StringUtils.isBlank(answer))) {
				return YxUtil.createFail("请配置正确的验证问题及答案");
			}
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
			if (role!=1&&role!=2) {
				return YxUtil.createFail("无权操作");
			}
			if(groupService.updateGroupJoinStatus(groupId, status, question, answer,fee)>0){
				return YxUtil.createSimpleSuccess("设置成功");
			}
			return YxUtil.createFail("设置失败");
		}
		return YxUtil.createFail("您不在该群组，无法操作");
		
	}
	
	@RequestMapping("/requestGroupJoin")
	@ResponseBody
	public ResponseData requestGroupJoin(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue = "0")long groupId,@RequestParam(defaultValue = "")String answer) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			return YxUtil.createFail("您已经是群组成员");
		}
		int flag=groupService.requestGroupJionWithQuestion(userId, groupId, answer);
		if (flag!=0) {
			String result="网络繁忙，请稍后重试";
			switch (flag) {
			case 1:result="验证消息不能为空";break;
			case 2:result="加群问题答案不正确";break;
			case 3:result="不允许加入";break;
			case 4:result="请先支付";break;
			case 5:result="群人数已经到达上限";break;
			default:result="网络繁忙，请稍后重试";break;
			}
			return YxUtil.createSimpleSuccess(-flag, result);
		}else{
			return YxUtil.createSimpleSuccess("申请成功");
		}
		
	}
	
	@RequestMapping("/payForGroupLevel")
	@ResponseBody
	public ResponseData payForGroupLevel(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long groupId,@RequestParam(defaultValue = "") String pwd,Integer level) throws IOException {
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
			if (role!=1) {
				return YxUtil.createFail("无权操作");
			}
			return groupService.payForGroupLevel(request, response, userId, groupId, pwd, level);
		}
		return YxUtil.createFail("您不在该群组，无法操作");	
	}
	
	@RequestMapping("/payForGroupJoin")
	@ResponseBody
	public ResponseData payForGroupJoin(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long groupId,@RequestParam(defaultValue = "") String pwd) throws IOException {
		ImGroupExtend groupExtend=groupService.groupInfo(groupId);
		if (groupExtend==null) {
			return YxUtil.createFail("群不存在");
		}
		return groupService.payForGroupJoin(userId, groupId, pwd);
	}
	
	/**
	 * 更新群成员信息
	 * @param request
	 * @param response
	 * @param userId  操作者
	 * @param groupId	群组id
	 * @param destId	更新用户
	 * @param type		更新类型 1 加群验证 2 禁言
	 * @param ope		更新内容 {0:拒绝加群，1:同意加群},{禁言时间：单位秒  例：600->十分钟}
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/updateGroupMember")
	@ResponseBody
	public ResponseData updateGroupMember(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long groupId,@RequestParam(defaultValue = "0") long destId,@RequestParam(defaultValue = "0") int type,@RequestParam(defaultValue = "") int ope) throws IOException {
		ImGroupExtend groupExtend=groupService.groupInfo(groupId);
		if (groupExtend==null) {
			return YxUtil.createFail("群不存在");
		}
		return groupService.updateGroupMember(userId, groupId, destId, type, ope);
	}
	
	@RequestMapping("/queryGroupConfig")
	@ResponseBody
	public ResponseData queryGroupConfig(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId) throws IOException {
		List list=groupService.getGroupConfig();
		if (list==null) {
			return YxUtil.createFail("获取配置信息失败，请稍后重试");
		}
		return YxUtil.createSimpleSuccess(list);
	}
	
	
	@RequestMapping("/payForGroupExt")
	@ResponseBody
	public ResponseData payForGroupExt(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long groupId,@RequestParam(defaultValue = "") String pwd) throws IOException {
		
		HashMap<String, Object> member=(HashMap<String, Object>) commonService.queryForObjectBySql("select * from im_group_member where userId=? and groupId=? and isAccept=1", userId,groupId);
		if (member!=null) {
			Integer role=Integer.parseInt(member.get("role")!=null?member.get("role").toString():"3");
			if (role!=1) {
				return YxUtil.createFail("无权操作");
			}
			return groupService.payForGroupExt(userId, groupId, pwd);
		}
		return YxUtil.createFail("您不在该群组，无法操作");	
	}
	
	@RequestMapping("/test")
	@ResponseBody
	public ResponseData test(HttpServletRequest request, HttpServletResponse response, long userId) throws IOException {
		if (userId>0) {
			return YxUtil.createSuccessData(userService.getUserBlackList(userId));
		}
		return YxUtil.createFail("举报发送失败");
		
	}
	
	@RequestMapping("/friendGroupCreate")
	@ResponseBody
	public ResponseData friendGroupCreate(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue="") String name) throws IOException {
		if (StringUtils.isBlank(name)) {
			return YxUtil.createFail("分组名称不能为空");
		}
		if (userId>0&&StringUtils.isNotBlank(name)) {
			return commonService.createFriendGroup(userId, name);
		}
		return YxUtil.createFail("分组创建失败");
		
	}
	
	@RequestMapping("/friendGroupUpdateInfo")
	@ResponseBody
	public ResponseData friendGroupUpdateInfo(HttpServletRequest request, HttpServletResponse response, long userId,long gid,@RequestParam(defaultValue="") String name) throws IOException {
		if (StringUtils.isBlank(name)) {
			return YxUtil.createFail("分组名称不能为空");
		}
		if (userId>0&&StringUtils.isNotBlank(name)) {
			return commonService.updateFriendGroupInfo(userId, gid, name);
		}
		return YxUtil.createFail("分组更新失败");
		
	}
	
	@RequestMapping("/friendGroupUpdateSort")
	@ResponseBody
	public ResponseData friendGroupUpdateSort(HttpServletRequest request, HttpServletResponse response, long userId,@RequestParam(defaultValue="0")long gid,@RequestParam(defaultValue="-1")int sort) throws IOException {
		if (userId>0&&sort>=0&&gid>0) {
			return commonService.updateFriendGroupSort(userId, gid, sort);
		}
		return YxUtil.createFail("分组更新失败");
		
	}
	
	@RequestMapping("/friendGroups")
	@ResponseBody
	public ResponseData friendGroups(HttpServletRequest request, HttpServletResponse response, long userId) throws IOException {
		return YxUtil.createSuccessData(commonService.getUserFriends(userId));
	}
	
	@RequestMapping("/updateFriendGroup")
	@ResponseBody
	public ResponseData updateFriendGroup(HttpServletRequest request, HttpServletResponse response, long userId,long destId,long gid) throws IOException {
		if (userId>0&&destId>=0&&gid>0) {
			return commonService.updateFriendGroup(userId, destId, gid);
		}
		return YxUtil.createFail("分组更新失败");
	}
	
	
	@RequestMapping("/removeFriendGroup")
	@ResponseBody
	public ResponseData removeFriendGroup(HttpServletRequest request, HttpServletResponse response, long userId,long gid) throws IOException {
		if (userId>0&&gid>0) {
			return commonService.removeFriendGroup(userId, gid);
		}
		return YxUtil.createFail("分组删除失败");
	}
	
	
	

	public static void main(String args[]) {
		ImMessage message = new ImMessage();
		message.setDestId(-1l);
		message.setFromId(11l);
		message.setMessageType(1);
		System.out.println(JSONObject.toJSONString(message));

		System.out.println(Utils.toMd5("1111"));
	}
}
