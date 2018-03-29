package com.yx.base.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.framework.service.EntityServiceImpl;
import com.yx.base.extendmodel.ImFriendGroup;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.util.YxUtil;

@SuppressWarnings("rawtypes")
@Service
public class CommonService extends EntityServiceImpl{

	public void findUser(){
		this.find("from ImUser where id<?",100l);
	}
	
	public void queryUser(){
		this.queryForObject("from ImUser where id=?", 33l);
	}
	
	/**
	 * 创建好友分组
	 * @param userId
	 * @param name
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public ResponseData createFriendGroup(Long userId,String name){
		try {
			this.setDefaultFriendGroup(userId);
		} catch (Exception e) {
		}
		List list=this.queryForObjListBySql("select * from im_friend_group where userId=?", userId);
		if (list != null && list.size() >= ImConstants.MAX_FRIEND_GROUP) {
			return YxUtil.createFail("创建失败，已达到最大用户分组数量");
		}
		ImFriendGroup friendGroup=new ImFriendGroup();
		friendGroup.setUserId(userId);
		friendGroup.setCreatetime(System.currentTimeMillis());
		friendGroup.setName(name);
		friendGroup.setSort(list.size()+1);
		friendGroup.setIsdefault(0);
		save(friendGroup);
		return YxUtil.createSuccessData(friendGroup);
	}
	
	/**
	 * 设置默认分组
	 * @param userId
	 */
	@SuppressWarnings("unchecked")
	public void setDefaultFriendGroup(Long userId){
		List list=this.queryForObjListBySql("select * from im_friend_group where userId=? and isdefault=1", userId);
		if (list != null && list.size() ==0) {
			// 没有默认分组创建默认分组
			ImFriendGroup friendGroup=new ImFriendGroup();
			friendGroup.setUserId(userId);
			friendGroup.setCreatetime(System.currentTimeMillis());
			friendGroup.setName("我的好友");
			friendGroup.setSort(0);
			friendGroup.setIsdefault(1);
			save(friendGroup);
			this.updateBySql("update im_friend set groupid=? where userId=?", friendGroup.getId(),userId);
		}else {
			ImFriendGroup defaultGroup=(ImFriendGroup) this.queryForObject("from ImFriendGroup where userId=? and isdefault=1", userId);
			this.updateBySql("update im_friend set groupid=? where userId=? and groupid=0", defaultGroup.getId(),userId);
		}
	}
	
	/**
	 * 获取我的分许列表
	 * @param userId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getUserFriends(Long userId){
		try {
			this.setDefaultFriendGroup(userId);
		} catch (Exception e) {
		}
		Map<String, Object> mygroup=new HashMap<>();
		List<HashMap<String, Object> > groups = queryForObjListBySql("select * from im_friend_group where userId=? order by sort asc", userId);
		if (groups!=null) {
			for (HashMap<String, Object> hashMap : groups) {
				mygroup.put("gid", hashMap.get("id"));
				mygroup.put("gname", hashMap.get("name"));
				List friendsInfo = queryForObjListBySql(
						"select a.remark,a.isBlack,a.receiveTip,b.id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,b.createTime,status,detail,headUrl,a.bgurl,b.imNumber as IMNo from im_friend a left join im_user b on(a.friendId=b.id) where a.userId=? and a.isFriend=1 and a.groupid=?",
						userId,hashMap.get("id"));
				mygroup.put("friends", friendsInfo);
			}
		}
		return mygroup;
	}
	
	/**
	 * 更新分组名称
	 * @param userId
	 * @param gid
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ResponseData updateFriendGroupInfo(Long userId,Long gid,String name){
		ImFriendGroup friendGroup=(ImFriendGroup) this.queryForObject("from ImFriendGroup where userId=? and id=?", userId,gid);
		if (friendGroup!=null) {
			friendGroup.setName(name);
			this.update(friendGroup);
			return YxUtil.createSuccessData(friendGroup);
		}
		return YxUtil.createFail("更新失败");
		
	}
	
	/**
	 * 删除分组
	 * @param userId
	 * @param gid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ResponseData removeFriendGroup(Long userId,Long gid){
		try {
			this.setDefaultFriendGroup(userId);
		} catch (Exception e) {
		}
		ImFriendGroup friendGroup=(ImFriendGroup) this.queryForObject("from ImFriendGroup where userId=? and id=?", userId,gid);
		if (friendGroup!=null) {
			if (friendGroup.getIsdefault()==1) {
				return YxUtil.createFail("默认分组无法删除");
			}
			ImFriendGroup defaultGroup=(ImFriendGroup) this.queryForObject("from ImFriendGroup where userId=? and isdefault=1", userId);
			//  删除当前分组
			this.delete(friendGroup);
			//  更新当前分组好友到默认群组
			this.updateBySql("update im_friend set groupid=? where userId=? and groupid=?", defaultGroup.getId(),userId,gid);
			return YxUtil.createSuccessData(this.getUserFriends(userId));
		}
		// 未查到分组信息
		return YxUtil.createFail("删除失败");
	}
	
	/**
	 * 将好友移动到分组
	 * @param userId
	 * @param destId
	 * @param gid
	 * @return
	 */
	public ResponseData updateFriendGroup(Long userId,Long destId,Long gid){
		if (this.updateBySql("update im_friend set groupid=? where userId=? and destId=?", gid,userId,gid,destId)>0) {
			return YxUtil.createSuccessData(this.getUserFriends(userId));
		}
		return YxUtil.createFail("分组更新失败");
	}
	
	/**
	 * 更新分组排序
	 * @param userId
	 * @param gid
	 * @param sort 新的位置
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ResponseData updateFriendGroupSort(Long userId,Long gid,int sort){
		ImFriendGroup friendGroup=(ImFriendGroup) this.queryForObject("from ImFriendGroup where userId=? and id=?", userId,gid);
		if (friendGroup!=null) {
			int oldsort= friendGroup.getSort();
			friendGroup.setSort(sort);
			if (oldsort>sort) {
				this.updateBySql("update im_friend_group set sort=sort+1 where sort<? and userId=? and sort>=?", oldsort,userId,sort);
				save(friendGroup);
			}else{
				this.updateBySql("update im_friend_group set sort=sort-1 where sort<? and userId=? and sort>=?", sort,userId,oldsort);
				save(friendGroup);
			}
			return YxUtil.createSuccessData(this.getUserFriends(userId));
		}
		return YxUtil.createFail("分组更新失败");
	}
}
