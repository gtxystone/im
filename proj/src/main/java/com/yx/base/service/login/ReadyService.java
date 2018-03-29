package com.yx.base.service.login;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.framework.service.EntityServiceImpl;
import com.yx.base.model.ImUserPay;

@SuppressWarnings("rawtypes")
@Service
public class ReadyService extends EntityServiceImpl {
	/**
	 * List friendsInfo = commonService.queryForObjListBySql( "select
	 * a.remark,a.isBlack,a.receiveTip,b.id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,b.createTime,status,detail,headUrl
	 * from im_friend a left join im_user b on(a.friendId=b.id) where a.userId=?
	 * and a.isFriend=1", userId); List groupsInfo =
	 * commonService.queryForObjListBySql( "select b.*,a.receiveTip from (select
	 * groupId,userId,receiveTip from im_group_member where userId=? and
	 * isaccept=1 group by groupId,userId,receiveTip) a LEFT JOIN im_group b
	 * on(a.groupId=b.id)", userId);
	 * 
	 * List topList = commonService.queryForObjListBySql("select
	 * userId,destType,destId from im_top where userId=?", userId);
	 * 
	 * ImUserPay payInfo=(ImUserPay)commonService.queryForObject("from ImUserPay
	 * where userId=?", userId);
	 * 
	 * @throws IOException
	 * 
	 */

	public List cacheFriendInfo(long userId) throws IOException {
		List friendsInfo = queryForObjListBySql(
				"select a.remark,a.isBlack,a.receiveTip,b.id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,b.createTime,status,detail,headUrl,a.bgurl,b.imNumber as IMNo from im_friend a left join im_user b on(a.friendId=b.id) where a.userId=? and a.isFriend=1",
				userId);

		return friendsInfo;
	}

	public List cacheGroupsInfo(long userId) throws IOException {
		List groupsInfo = queryForObjListBySql(
				"select b.*,a.receiveTip,a.markName,a.bgurl,a.role,a.silence from (select markName,groupId,userId,receiveTip,bgurl,role,silence from im_group_member where userId=? and isAccept=1 group by groupId,userId,receiveTip) a LEFT JOIN im_group b on(a.groupId=b.id)",
				userId);

		return groupsInfo;
	}

	public List cacheTopList(long userId) throws IOException {
		List topList = queryForObjListBySql("select userId,destType,destId from im_top where userId=?", userId);
		// byte[] data=Utils.serializeObjectToBytes(topList);
		// RedisUtil.expired(RedisKey.getTopKey(userId), 60*60*24);
		// RedisUtil.set(RedisKey.getTopKey(userId),data);
		return topList;
	}

	public ImUserPay cacheImUserPay(long userId) throws IOException {
		ImUserPay payInfo = (ImUserPay) queryForObject("from ImUserPay where userId=?", userId);
		return payInfo;
	}

	public List getFriendInfo(long userId) throws IOException {
		return cacheFriendInfo(userId);
	}

	public List getGroupsInfo(long userId) throws IOException {

		return cacheGroupsInfo(userId);

		/*
		 * return queryForObjListBySql(
		 * "select b.*,a.receiveTip,a.markName from (select markName,groupId,userId,receiveTip from im_group_member where userId=? and isaccept=1 group by groupId,userId,receiveTip) a LEFT JOIN im_group b on(a.groupId=b.id)"
		 * , userId);
		 */
	}

	public List getTopList(long userId) throws IOException {

		return cacheTopList(userId);

	}

	public ImUserPay getImUserPay(long userId) throws IOException {

		return cacheImUserPay(userId);

	}

}
