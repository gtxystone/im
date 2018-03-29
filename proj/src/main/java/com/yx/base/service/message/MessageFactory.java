package com.yx.base.service.message;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.framework.util.Utils;
import com.yx.base.extendmodel.ImFeedExtend;
import com.yx.base.extendmodel.ImGroupExtend;
import com.yx.base.extendmodel.ImTransForm;
import com.yx.base.model.ImFeed;
import com.yx.base.model.ImFeedComment;
import com.yx.base.model.ImFeedPraise;
import com.yx.base.model.ImGroup;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImRedpacket;
import com.yx.base.model.ImTransform;
import com.yx.base.model.ImUser;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.service.CommonService;
import com.yx.base.service.group.GroupService;
import com.yx.base.service.user.UserService;

import io.netty.util.internal.StringUtil;

@Service
public class MessageFactory {
	
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private UserService userService;
	
	
	
	public ImMessage newFeedNotice(ImFeed feed,long destId) throws IOException{
		ImUser user=userService.getImUser(feed.getUserId());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(feed.getUserId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"feedId\":"+feed.getId()+",\"msg\":\""+feed.getFeedText()+"\",\"imgs\":\""+feed.getFeedImgs()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_NEW_FEED);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	//	提到了
	public ImMessage remindFeedNotice(ImFeedExtend feed,long destId) throws IOException{
		ImUser user=userService.getImUser(feed.getUserId());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(feed.getUserId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"feedId\":"+feed.getId()+",\"msg\":\"\",\"feedmsg\":\""+feed.getFeedText()+"\",\"imgs\":\""+feed.getFeedImgs()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(ImConstants.MSG_TYPE_FEED_AT);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	public ImMessage referFeedCommentNotice(ImFeedComment feedComment,long destId) throws IOException{
		ImUser user=userService.getImUser(feedComment.getUserId());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(feedComment.getUserId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"feedId\":"+feedComment.getImFeed().getId()+",\"msg\":\""+feedComment.getCommentText()+"\",\"feedmsg\":\""+feedComment.getImFeed().getFeedText()+"\",\"imgs\":\""+feedComment.getImFeed().getFeedImgs()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_REFER_FEED);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	public ImMessage referFeedPraiseNotice(ImFeedPraise feedPraise,long destId) throws IOException{
		ImUser user=userService.getImUser(feedPraise.getUserId());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(feedPraise.getUserId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"feedId\":"+feedPraise.getImFeed().getId()+",\"feedmsg\":\""+feedPraise.getImFeed().getFeedText()+"\",\"imgs\":\""+feedPraise.getImFeed().getFeedImgs()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_REFER_PRAISE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 转账退回通知
	 * @param trans 转账实体
	 * @return
	 */
	public ImMessage transferBackNotice(ImTransform trans){
		ImMessage msg=new ImMessage();
		msg.setDestId(trans.getUserId());
		msg.setFromId(trans.getDestId());
		msg.setContent("{\"transId\":"+trans.getId()+",\"msg\":\""+trans.getMsg()+"\",\"amount\":\""+trans.getAmount()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_TRANSFER_BACK);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 到账通知
	 * @param 
	 * @param fromId 
	 * @return
	 * @throws IOException 
	 */
	public ImMessage receiveMoneyNotice(long fromId,long destId,BigDecimal amt) throws IOException{	
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"amt\":"+amt+"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_REC_MONEY);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 转账已收钱通知
	 * @param trans 转账实体
	 * @param fromId 确认收钱人
	 * @return
	 * @throws IOException 
	 */
	public ImMessage transferRecNotice(ImTransform trans) throws IOException{				
		ImMessage msg=new ImMessage();
		ImUser user=userService.getImUser(trans.getDestId());
		msg.setDestId(trans.getUserId());
		msg.setFromId(trans.getDestId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"transId\":"+trans.getId()+",\"msg\":\""+trans.getMsg()+"\",\"amount\":\""+trans.getAmount()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_TRANSFER_REC);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 转账通知
	 * @param transId 转账id
	 * @param fromId 发起人
	 * @param destId 接收人
	 * @param message 转账留言
	 * @return
	 * @throws IOException 
	 */
	public ImMessage transferNotice(long transId,long fromId,long destId,String message,BigDecimal amount) throws IOException{
		ImMessage msg=new ImMessage();
		ImUser user=userService.getImUser(fromId);
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"transId\":"+String.valueOf(transId)+",\"msg\":\""+message+"\",\"amount\":\""+amount+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_TRANSFER);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 群组转账通知
	 * @param transId 转账id
	 * @param fromId 发起人
	 * @param destId 接收人
	 * @param message 转账留言
	 * @return
	 * @throws IOException 
	 */
	public ImMessage transferNotice(long transId,long fromId,long destId,String message,BigDecimal amount,long groupId) throws IOException{
		ImMessage msg=new ImMessage();
		ImUser user=userService.getImUser(fromId);
		msg.setDestId(groupId);
		msg.setFromId(fromId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"transId\":"+String.valueOf(transId)+",\"msg\":\""+message+"\",\"amount\":\""+amount+"\",\"destId\":\""+destId+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_GROUP);
		msg.setMessageType(IMConstants.MSG_TYPE_TRANSFER);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 群组转账已收钱通知
	 * @param trans 转账实体
	 * @param fromId 确认收钱人
	 * @return
	 * @throws IOException 
	 */
	public ImMessage transferRecNotice(ImTransForm trans) throws IOException{				
		ImMessage msg=new ImMessage();
		ImUser user=userService.getImUser(trans.getDestId());
		msg.setDestId(trans.getUserId());
		msg.setFromId(trans.getGroupId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"transId\":"+trans.getId()+",\"msg\":\""+trans.getMsg()+"\",\"amount\":\""+trans.getAmount()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_GROUP);
		msg.setMessageType(IMConstants.MSG_TYPE_TRANSFER_REC);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 红包退回通知
	 * @param trans 红包实体
	 * @param lastAmount 退回金额
	 * @return
	 */
	public ImMessage redPacketBackNotice(ImRedpacket redpacket,BigDecimal lastAmount){
		ImMessage msg=new ImMessage();
		msg.setDestId(redpacket.getUserId());
		msg.setFromId(redpacket.getDestId());
		msg.setContent("{\"redPacketId\":"+redpacket.getId()+",\"msg\":\""+redpacket.getRedPacketContent()+"\",\"amount\":\""+lastAmount+"\"}");
		msg.setFromType(redpacket.getDestType());
		msg.setMessageType(IMConstants.MSG_TYPE_REDPACKET_BACK);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 红包被人接收时，通知发红包人
	 * @param redPacketId 红包id
	 * @param fromId 抢到红包的人
	 * @param destId 群或者人id
	 * @param fromType 1是2是群
	 * @param redPacketContent 红包留言
	 * @return
	 * @throws IOException 
	 */
	public ImMessage receiveRedPacketNotice(long redPacketId,long fromId,long destId,int fromType,String redPacketContent) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setFromId(fromId);
		msg.setContent("{\"redPacketId\":"+String.valueOf(redPacketId)+",\"msg\":\""+redPacketContent+"\"}");
		msg.setFromType(fromType);
		msg.setMessageType(IMConstants.MSG_TYPE_RECEIVE_RED_NOTICE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 红包被人抢光时，通知发红包人
	 * @param redPacketId 红包id
	 * @param fromId 最后一个抢到红包的人
	 * @param destId 群或者人id
	 * @param fromType 1是2是群
	 * @param redPacketContent 红包留言
	 * @return
	 * @throws IOException 
	 */
	public ImMessage receiveRedFinishedNotice(long redPacketId,long fromId,long destId,int fromType,String redPacketContent) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setContent("{\"redPacketId\":"+String.valueOf(redPacketId)+",\"msg\":\""+redPacketContent+"\"}");
		msg.setFromType(fromType);
		msg.setMessageType(IMConstants.MSG_TYPE_RED_FINISHED);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 发红包通知
	 * @param redPacketId 红包id
	 * @param fromId 发红包的人
	 * @param destId 接收消息的人或者群id
	 * @param fromType 1为人，2为群
	 * @return
	 * @throws IOException 
	 */
	public ImMessage redPacketNotice(long redPacketId,long userId,long destId,int fromType,String redPacketContent) throws IOException{
		ImUser user=userService.getImUser(userId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(user.getId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"redPacketId\":"+String.valueOf(redPacketId)+",\"msg\":\""+redPacketContent+"\"}");
		msg.setFromType(fromType);
		msg.setMessageType(IMConstants.MSG_TYPE_RED_PACKET);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 口令红包已经开完
	 * @param redPacketId 红包id
	 * @param fromId 抢到红包的人
	 * @param destId 群或者人id
	 * @param fromType 1是2是群
	 * @param redPacketContent 红包留言
	 * @return
	 * @throws IOException 
	 */
	public ImMessage commandRedPacketNotice(long redPacketId,long fromId,long destId,int fromType,String redPacketContent) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setFromId(fromId);
		msg.setContent("{\"redPacketId\":"+String.valueOf(redPacketId)+",\"msg\":\""+redPacketContent+"\"}");
		msg.setFromType(fromType);
		msg.setMessageType(ImConstants.MSG_TYPE_COMMAND_RED_NOTICE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 好友上线通知
	 * @param fromId
	 * @param destId
	 * @return
	 */
	public ImMessage userOnlineNotice(long fromId,long destId){
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_ONLINE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 好友离线通知
	 * @param fromId
	 * @param destId
	 * @return
	 */
	public ImMessage userOfflineNotice(long fromId,long destId){
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_OFFLINE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 好友解除好友关系
	 * @param fromId
	 * @param destId
	 * @return
	 * @throws IOException 
	 */
	public ImMessage delFriendNotice(long fromId,long destId) throws IOException{
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_DEL_FRIEND);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 有人加入了群
	 * @param fromId 加入人
	 * @param destId 群id
	 * @return
	 * @throws IOException 
	 */
	public ImMessage joinedGroupNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setFromId(fromId);
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_JOIN_GROUP);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 群名称被修改通知
	 * @param fromId 修改人
	 * @param destId 群id
	 * @return
	 * @throws IOException 
	 */
	public ImMessage modifyGroupNotice(long fromId,long destId,String name) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(name);
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_MODIFY_GROUP);
		msg.setMsgId(Utils.getUUID());
		msg.setContent(name);
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 群成员修改了备注名通知
	 * @param fromId 修改人
	 * @param destId 群id
	 * @param comment 新备注
	 * @return
	 * @throws IOException 
	 */
	public ImMessage modifyGroupCommentNotice(long fromId,long destId,String comment) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setContent(comment);
		msg.setMessageType(IMConstants.MSG_TYPE_MODIFY_GROUP_COMMENT);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 有人退出了群
	 * @param fromId 退出人
	 * @param destId 群id
	 * @return
	 * @throws IOException 
	 */
	public ImMessage quitGroupNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_QUIT_GROUP);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 有人被邀请加入了群
	 * @param fromId 被邀请人
	 * @param destId 群id
	 * @return
	 * @throws IOException 
	 */
	public ImMessage inviteGroupNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_INVITE_GROUP);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 有人请求加好友
	 * @param fromId 请求人
	 * @param destId 被请求人
	 * @return
	 * @throws IOException 
	 */
	public ImMessage friendReqNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_FRIEND_REQ);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 修改了资料通知好友
	 * @param fromId 修改资料的人
	 * @param destId 好友
	 * @return
	 */
	public ImMessage userModifyProfileNotice(long fromId,long destId,ImUser user){
		HashMap<String, Object> imUser=new HashMap<>();
		imUser.put("nickName", user.getNickName());
		imUser.put("district", StringUtils.isBlank(user.getDistrict())?"":user.getDistrict());
		imUser.put("city", StringUtils.isBlank(user.getCity())?"":user.getCity());
		imUser.put("province", StringUtils.isBlank(user.getProvince())?"":user.getProvince());
		imUser.put("name", StringUtils.isBlank(user.getName())?"":user.getName());
		imUser.put("sex", StringUtils.isBlank(user.getSex())?"":user.getSex());
		imUser.put("sign", StringUtils.isBlank(user.getSign())?"":user.getSign());
		imUser.put("headUrl", StringUtils.isBlank(user.getHeadUrl())?"":user.getHeadUrl());
		imUser.put("id", user.getId());
		imUser.put("feedBackImage", user.getFeedBackImage());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent(JSON.toJSONString(imUser));
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_MODIFY_PROFILE);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 自动加为好友时通知双方
	 * @param fromId 同意的人
	 * @param destId 被同意的人
	 * @return
	 * @throws IOException 
	 */
	public ImMessage friendNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_AUTO_FRIEND);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 请求好友通过
	 * @param fromId 同意的人
	 * @param destId 被同意的人
	 * @return
	 * @throws IOException 
	 */
	public ImMessage acceptFriendNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_ACCEPT_FRIEND);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 请求加入群
	 * @param fromId 申请人
	 * @param destId 群id
	 * @return
	 * @throws IOException 
	 */
	public ImMessage groupReqNotice(long fromId,long destId) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setContent("{\"name\":\""+user.getName()+"\",\"headUrl\":\""+user.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_GROUP_REQ);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 群请求被通过
	 * @param fromId 审核人
	 * @param destId 群id
	 * @return
	 */
	public ImMessage acceptGroupNotice(long fromId,long destId){
		ImGroup group=(ImGroup)commonService.queryForObject("from ImGroup where id=?", destId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setContent("{\"name\":\""+group.getName()+"\",\"headUrl\":\""+group.getHeadUrl()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_ACCEPT_GROUP);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	/**
	 * 其它地方登陆，强制下线通知
	 * @param fromId
	 * @return
	 */
	public ImMessage otherLoginNotice(long fromId){
		ImMessage msg=new ImMessage();
		msg.setDestId(fromId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_OTHER_LOGIN);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
	/**
	 * 群通知发送
	 * @param fromId 通知发送者
	 * @param destId 群id
	 * @param content 消息体
	 * @return
	 * @
	 * @throws IOException 
	 */
	public ImMessage modifyGroupNoticeCommon(long fromId,long destId,String content,Integer msgType) throws IOException{
		ImUser user=userService.getImUser(fromId);
		ImMessage msg=new ImMessage();
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setDestId(destId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setContent(content);
		msg.setMessageType(msgType);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	public ImMessage newFeedNotice(ImFeedExtend feed, Long destId) throws IOException{
		ImUser user=userService.getImUser(feed.getUserId());
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(feed.getUserId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"feedId\":"+feed.getId()+",\"msg\":\""+feed.getFeedText()+"\",\"imgs\":\""+feed.getFeedImgs()+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_P2P);
		msg.setMessageType(IMConstants.MSG_TYPE_NEW_FEED);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	/**
	 * 带口令的红包消息体
	 * @param redPacketId
	 * @param userId
	 * @param destId
	 * @param fromType
	 * @param redPacketContent
	 * @param command
	 * @param redPacketType
	 * @return
	 * @throws IOException
	 */
	public ImMessage redPacketNotice(long redPacketId,long userId,long destId,int fromType,String redPacketContent,
			String command,int redPacketType) throws IOException {
		ImUser user=userService.getImUser(userId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(user.getId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"redPacketId\":"+String.valueOf(redPacketId)+",\"msg\":\""+redPacketContent+"\",\"command\":\""+command+"\",\"redPacketType\":\""+redPacketType+"\"}");
		msg.setFromType(fromType);
		msg.setMessageType(IMConstants.MSG_TYPE_RED_PACKET);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	public ImMessage otherLoginNotice(long fromId, String content) {
		ImMessage msg=new ImMessage();
		msg.setDestId(fromId);
		msg.setFromId(fromId);
		msg.setContent(content);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_OTHER_LOGIN);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	public ImMessage aaTransNotice(long userId,long destId,int destType,String content) throws IOException{
		ImMessage message=new ImMessage();
		ImUser user=userService.getImUser(userId);
		message.setContent(content);
		message.setDestId(destId);
		message.setFromId(userId);
		message.setFromName(user.getName());
		message.setImageIconUrl(user.getHeadUrl());
		message.setMessageType(IMConstants.MSG_TYPE_AA_RECEIVE);
		message.setFromType(destType);
		message.setMsgId(Utils.getUUID());
		message.setSendTime(System.currentTimeMillis());
		return message;
	}
	
	
	public ImMessage sayHelloNotice(long userId,long destId,Long pid,String message) throws IOException {
		ImUser user=userService.getImUser(userId);
		ImMessage msg=new ImMessage();
		msg.setDestId(destId);
		msg.setFromId(user.getId());
		msg.setFromName(user.getName());
		msg.setImageIconUrl(user.getHeadUrl());
		msg.setContent("{\"pid\":"+String.valueOf(pid)+",\"msg\":\""+message+"\"}");
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(ImConstants.NOTICE_OF_HELLO);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	
	
}
