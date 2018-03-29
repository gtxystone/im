package com.yx.base.service.feed;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.beanutils.BeanMap;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.framework.model.Page;
import com.framework.model.Page.OrderType;
import com.framework.service.EntityServiceImpl;
import com.google.common.primitives.Longs;
import com.mysql.fabric.xmlrpc.base.Array;
import com.yx.base.document.model.Feed;
import com.yx.base.document.model.FeedComment;
import com.yx.base.document.model.FeedPraise;
import com.yx.base.document.model.FeedUser;
import com.yx.base.document.model.MongoPage;
import com.yx.base.extendmodel.ImFeedExtend;
import com.yx.base.extendmodel.ImFeedGift;
import com.yx.base.model.ImFeed;
import com.yx.base.model.ImFeedComment;
import com.yx.base.model.ImFeedPraise;
import com.yx.base.model.ImFriend;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImUser;
import com.yx.base.service.CommonService;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.user.UserService;
import com.yx.base.util.YxUtil;

@SuppressWarnings("rawtypes")
@Service
public class FeedService extends EntityServiceImpl {

	@Autowired
	private MongoTemplate mongoTemplate;

	@Autowired
	private CommonService commonService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private MessageFactory messageFactory;
	
	@Autowired
	private MsgStoreAndNotify chatService;

	public MongoPage getFeed(long userId, int pageNo) {
		MongoPage page = new MongoPage();
		page.setPageNo(pageNo);
		Set<Long> blackid = userService.getUserBlackList(userId);
		Query query = Query.query(Criteria.where("belongUserId").is(userId).and("userId").nin(blackid));
		// 查询总数
		int count = (int) mongoTemplate.count(query, Feed.class);
		page.setTotalCount(count);

		// 排序
		query.with(new Sort(Direction.DESC, "createTime"));
		query.skip(page.getSkip()).limit(page.getPageSize());

		List<Feed> datas = mongoTemplate.find(query, Feed.class);
		page.setList(datas);
		return page;
	}
	
	public MongoPage getFeed2(long userId, int pageNo) {
		MongoPage page = new MongoPage();
		String ids=userService.getFriendsIds(userId);
		
		
		Query query = Query.query(Criteria.where("belongUserId").is(userId).and("imFeedComments.userId").in(ids));
		// 查询总数
		int count = (int) mongoTemplate.count(query, Feed.class);
		page.setTotalCount(count);

		// 排序
		query.with(new Sort(Direction.DESC, "createTime"));
		query.skip(page.getSkip()).limit(page.getPageSize());

		List<Feed> datas = mongoTemplate.find(query, Feed.class);
		page.setList(datas);
		return page;
	}
	
	public MongoPage getMyFeed(long userId, MongoPage page) {
				
		Query query = Query.query(Criteria.where("belongUserId").is(userId).and("userId").is(userId));
		// 查询总数
		int count = (int) mongoTemplate.count(query, Feed.class);
		page.setTotalCount(count);

		// 排序
		query.skip(page.getSkip()).limit(page.getPageSize());
		query.with(new Sort(Direction.DESC, "createTime"));
		
		List<Feed> datas = mongoTemplate.find(query, Feed.class);
		page.setList(datas);
		return page;
	}

	public void addFeedComment(long feedId, String text, long userId, long replyId) {
		try {
			ImFeed dbFeed = (ImFeed) this.queryForObject("from ImFeed where id=?", feedId);
			ImUser user=(ImUser)this.queryForObject("from ImUser where id=?", userId);
			ImUser replyUser=(ImUser)this.queryForObject("from ImUser where id=?", replyId);
			
			Set<Long> expcets=new HashSet<>();//  三方有一方设置了权限或者
			expcets.addAll(userService.getFeedExcept(dbFeed.getUserId()));
			if (expcets.contains(userId)) {
				return;
			}

			ImFeedComment dbComment = new ImFeedComment();
			dbComment.setCommentText(text);
			dbComment.setCreateTime(System.currentTimeMillis());
			dbComment.setImFeed(dbFeed);
			dbComment.setReplyUserId(replyId);
			dbComment.setUserId(userId);
			dbComment.setUserName(user.getName());
			dbComment.setUserHeadUrl(user.getHeadUrl());
			if(replyUser!=null&&replyUser.getName()!=null){
				dbComment.setReplyUserName(replyUser.getName());
				dbComment.setReplyUserHeadUrl(replyUser.getHeadUrl());
			}
			commonService.save(dbComment);

			FeedComment comment = new FeedComment();
			comment.setId(dbComment.getId());
			comment.setCreateTime(dbComment.getCreateTime());
			comment.setCommentText(dbComment.getCommentText());
			comment.setReplyUserId(replyId);
			comment.setUserId(userId);
			comment.setUserHeadUrl(dbComment.getUserHeadUrl());
			comment.setUserName(dbComment.getUserName());
			comment.setReplyUserHeadUrl(dbComment.getReplyUserHeadUrl());
			comment.setReplyUserName(dbComment.getReplyUserName());
			mongoTemplate.save(comment);

			long feedCreatorId = dbFeed.getUserId();

			Update update = new Update();


				// 评论我朋友的动态,推送给我与好友的交集。
				Set<byte[]> ids = userService.getMixFriend(feedCreatorId, userId,replyId);
				for (byte[] idb : ids) {
					long id = Longs.fromByteArray(idb);
					mongoTemplate.updateMulti(
							Query.query(Criteria.where("feedId").is(feedId).and("belongUserId").in(id)),
							update.push("imFeedComments", comment), Feed.class);
				}
				List<Long> push=new ArrayList<>();
				push.add(userId);
				push.add(feedCreatorId);
				if (replyId>0) {
					push.add(replyId);
				}
				mongoTemplate.updateMulti(
						Query.query(Criteria.where("feedId").is(feedId).and("belongUserId")
								.in(push)),
						update.push("imFeedComments", comment), Feed.class);
				

				
				//	推送给参与人
				Feed feed=mongoTemplate.findOne(Query.query(Criteria.where("feedId").is(feedId).and("belongUserId").in(userId)), Feed.class);
				Set<Long> friendIds=new HashSet<Long>();
				friendIds.add(feedCreatorId);
				if(feed.getImFeedComments()!=null&&feed.getImFeedComments().size()>0){
					for(FeedComment tempComment:feed.getImFeedComments()){
						friendIds.add(tempComment.getUserId());
					}
				}
				
				if(feed.getImFeedPraises()!=null&&feed.getImFeedPraises().size()>0){
					for(FeedPraise temp:feed.getImFeedPraises()){
						friendIds.add(temp.getUserId());
					}
				}
				friendIds.remove(userId);
				//	
				for(long id:friendIds){
					ImMessage msg=messageFactory.referFeedCommentNotice(dbComment, id);
					chatService.storeMsgAndNotifyImServer(msg, id);
				}
				//	推送给参与人止
				
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void canclePraise(long feedId,long userId){
		Query q=Query.query(Criteria.where("feedId").is(feedId));
		this.updateBySql("delete from im_feed_praise where feed_id=? and user_id=?", feedId,userId);
		Update update = new Update();

		List<Feed> feeds=mongoTemplate.find(q, Feed.class);
		if(feeds!=null&&feeds.size()>0)
		for(Feed feed:feeds){
			List<FeedPraise> praises=feed.getImFeedPraises();
			if(praises!=null&&praises.size()>0)
			for(FeedPraise praise:praises){
				if(praise.getUserId()==userId){
					mongoTemplate.updateMulti(q,update.pull("imFeedPraises", praise), Feed.class);
				}
			}
		}		
	}
	
	public void deleteFeed(long feedId,long userId){
		Query q=Query.query(Criteria.where("feedId").is(feedId));
		this.updateBySql("delete from im_feed where id=? and user_id=?", feedId,userId);
		mongoTemplate.remove(q, Feed.class);
				
	}
	
	public void deleteFriendFeed(long userId,long destId){
		Query q=Query.query(Criteria.where("belongUserId").is(userId).and("userId").is(destId));
		mongoTemplate.remove(q, Feed.class);
		
		q=Query.query(Criteria.where("belongUserId").is(destId).and("userId").is(userId));
		mongoTemplate.remove(q, Feed.class);
	}
	
	public Feed getOneFeed(long feedId,long userId){
		Query q=Query.query(Criteria.where("feedId").is(feedId).and("belongUserId").is(userId));
		Feed feed=mongoTemplate.findOne(q, Feed.class);
		return feed;
				
	}

	public void addFeedPraise(long feedId, long userId) {
		try {

			ImFeed dbFeed = (ImFeed) this.queryForObject("from ImFeed where id=?", feedId);
			ImUser user=(ImUser)this.queryForObject("from ImUser where id=?", userId);
			
			Set<Long> expcets=new HashSet<>();//  三方有一方设置了权限或者
			expcets.addAll(userService.getFeedExcept(dbFeed.getUserId()));
			if (expcets.contains(userId)) {
				return;
			}
			ImFeedPraise dbPraise = new ImFeedPraise();
			dbPraise.setCreateTime(System.currentTimeMillis());
			dbPraise.setImFeed(dbFeed);
			dbPraise.setUserId(userId);
			dbPraise.setUserName(user.getName());
			dbPraise.setUserHeadUrl(user.getHeadUrl());
			commonService.save(dbPraise);

			FeedPraise praise = new FeedPraise();
			praise.setCreateTime(dbPraise.getCreateTime());
			praise.setId(dbPraise.getId());
			praise.setUserId(dbPraise.getUserId());
			praise.setUserName(dbPraise.getUserName());
			praise.setUserHeadUrl(dbPraise.getUserHeadUrl());
			mongoTemplate.save(praise);

			long feedCreatorId = dbFeed.getUserId();

			Update update = new Update();

				// zan我的朋友的动态,推送给我与好友交集的好友。
				Set<byte[]> ids = userService.getMixFriend(feedCreatorId, userId,0);
				for (byte[] idb : ids) {
					long id = Longs.fromByteArray(idb);
					System.out.println(id);
					mongoTemplate.updateMulti(
							Query.query(Criteria.where("feedId").is(feedId).and("belongUserId").in(id)),
							update.push("imFeedPraises", praise), Feed.class);
				}
				mongoTemplate.updateMulti(
						Query.query(Criteria.where("feedId").is(feedId).and("belongUserId")
								.in(new Long[] { feedCreatorId, userId })),
						update.push("imFeedPraises", praise), Feed.class);
				
				
				//推送给参与人
				Feed feed=mongoTemplate.findOne(Query.query(Criteria.where("feedId").is(feedId).and("belongUserId").in(userId)), Feed.class);
				Set<Long> friendIds=new HashSet<Long>();
				friendIds.add(feedCreatorId);
				if(feed.getImFeedComments()!=null&&feed.getImFeedComments().size()>0){
					for(FeedComment tempComment:feed.getImFeedComments()){
						friendIds.add(tempComment.getUserId());
					}
				}
				
				if(feed.getImFeedPraises()!=null&&feed.getImFeedPraises().size()>0){
					for(FeedPraise temp:feed.getImFeedPraises()){
						friendIds.add(temp.getUserId());
					}
				}
				friendIds.remove(userId);
				
				for(long id:friendIds){
					ImMessage msg=messageFactory.referFeedPraiseNotice(dbPraise, id);
					chatService.storeMsgAndNotifyImServer(msg, id);
				}
				//推送给参与人止
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ImFeed addFeed(String images, String text, long userId) {
		try {
			ImUser user=(ImUser)this.queryForObject("from ImUser where id=?", userId);
			ImFeed imFeed = new ImFeed();
			imFeed.setCreateTime(System.currentTimeMillis());
			imFeed.setFeedImgs(images);
			imFeed.setFeedText(text);
			imFeed.setStatus(1);
			imFeed.setUserId(userId);
			imFeed.setUserName(user.getName());
			imFeed.setUserHeadUrl(user.getHeadUrl());
			save(imFeed);

			Feed feed = new Feed();
			feed.setCreateTime(imFeed.getCreateTime());
			feed.setFeedImgs(imFeed.getFeedImgs());
			feed.setFeedText(imFeed.getFeedText());
			feed.setStatus(imFeed.getStatus());
			feed.setUserName(imFeed.getUserName());
			feed.setUserHeadUrl(imFeed.getUserHeadUrl());
			feed.setUserId(imFeed.getUserId());
			feed.setFeedId(imFeed.getId());

			// 保存给自己
			feed.setBelongUserId(userId);
			mongoTemplate.save(feed);
			// 保存给好友
			List<ImFriend> friends = userService.getFriends(userId);
			for (ImFriend friend : friends) {
				feed.setId(new ObjectId().toString());
				feed.setBelongUserId(friend.getFriendId());
				mongoTemplate.save(feed);
				//给好友推送消息
				ImMessage message=messageFactory.newFeedNotice(imFeed, friend.getFriendId());
				chatService.storeMsgAndNotifyImServer(message, friend.getFriendId());
			}

			return imFeed;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public ImFeedExtend addFeed(String images, String text, long userId,
			String lat, String lng, String address, int priv,
			String at, String uids,String video,String ext) {
		try {
			ImUser user=(ImUser)this.queryForObject("from ImUser where id=?", userId);
			ImFeedExtend imFeed = new ImFeedExtend();
			imFeed.setCreateTime(System.currentTimeMillis());
			imFeed.setFeedImgs(images);
			imFeed.setFeedText(text);
			imFeed.setStatus(1);
			imFeed.setUserId(userId);
			imFeed.setUserName(user.getName());
			imFeed.setUserHeadUrl(user.getHeadUrl());
			imFeed.setLng(lng);
			imFeed.setLat(lat);
			imFeed.setAddress(address);
			imFeed.setPriv(priv);
			imFeed.setAt(at);
			imFeed.setUids(uids);
			imFeed.setFeedVideo(video);
			imFeed.setExt(ext);
			save(imFeed);

			Feed feed = new Feed();
			feed.setCreateTime(imFeed.getCreateTime());
			feed.setFeedImgs(imFeed.getFeedImgs());
			feed.setFeedText(imFeed.getFeedText());
			feed.setStatus(imFeed.getStatus());
			feed.setUserName(imFeed.getUserName());
			feed.setUserHeadUrl(imFeed.getUserHeadUrl());
			feed.setUserId(imFeed.getUserId());
			feed.setFeedId(imFeed.getId());
			feed.setLng(lng);
			feed.setLat(lat);
			feed.setAddress(address);
			feed.setPriv(priv);
			feed.setAt(at);
			feed.setUids(uids);
			feed.setFeedVideo(video);
			feed.setExt(ext);

			// 保存给自己
			feed.setBelongUserId(userId);
			mongoTemplate.save(feed);
			// 保存给好友
			List<ImFriend> friends = userService.getFriends(userId);
			Set<Long> excepts=userService.getFeedExcept(userId);
			Set atUsers=new HashSet<>();
			for (ImFriend friend : friends) {
				if (excepts.contains(friend.getFriendId())) {
					continue;
				}
				Boolean flag=isAppend(friend.getFriendId(), uids, priv);
				Boolean bool=isAppend(friend.getFriendId(), at, 2);
				if (flag) {
					feed.setId(new ObjectId().toString());
					feed.setBelongUserId(friend.getFriendId());
					mongoTemplate.save(feed);
					//给好友推送消息
					ImMessage message=messageFactory.newFeedNotice(imFeed, friend.getFriendId());
					chatService.storeMsgAndNotifyImServer(message, friend.getFriendId());
				}
				if (bool) {
					// 保存提醒人的用户信息
					ImUser fuser=userService.getImUser(friend.getFriendId());
					FeedUser atUser=new FeedUser();
					atUser.setUserName(org.apache.commons.lang.StringUtils.isBlank(friend.getRemark())?fuser.getNickName():friend.getRemark());
					atUser.setUserHeadUrl(fuser.getHeadUrl());
					atUser.setUserId(fuser.getId());
					atUser.setFeedId(imFeed.getId());
					mongoTemplate.save(atUser);
					atUsers.add(atUser);
					Update update=new Update();
					List<Long> in=new ArrayList<>();
					in.add(fuser.getId());
					in.add(userId);
					mongoTemplate.updateMulti(
							Query.query(Criteria.where("feedId").is(imFeed.getId()).and("belongUserId")
									.in(in)),
							update.push("atUsers", atUser), Feed.class);
					//给好友推送@消息
					ImMessage message=messageFactory.remindFeedNotice(imFeed, friend.getFriendId());
					chatService.storeMsgAndNotifyImServer(message, friend.getFriendId());
				}
				
			}
//			System.out.println(JSON.toJSON(atUsers).toString());
			return imFeed;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private Boolean isAppend(long userId,String uids,int priv) throws IOException{
		String[] users={};
		if (!org.apache.commons.lang.StringUtils.isBlank(uids)) {
			users=uids.split(",");
		}
//		System.out.println("uids="+JSON.toJSON(users).toString());
		ArrayList<Long> list=new ArrayList<>();
		for (int i = 0; i < users.length; i++) {
			list.add(Long.parseLong(users[i]));
		}
		// 0 公开全返 true 1 私人 全返false  2 部分人可看 在uid[] 的为true 3 部分人不可看 在uid[]的为false
		Boolean flag=false;
		switch (priv) {
		case 0:
			flag=true;
			break;
		case 1:
			flag=false;
			break;
		case 2:
			flag=list.contains(userId);
			break;
		case 3:
			flag=!list.contains(userId);
			break;
		default:
			break;
		}
//		System.out.println("验证用户ID："+userId+"验证结果："+flag);
		return flag;
	}
	/**
	 * 用户修改资料时候更新朋友圈保存的用户数据
	 * 包括 评论点赞 还有@
	 * @param userId
	 */
	public void updateFeed(long userId,String userName,String headUrl){
		Query query=Query.query(Criteria.where("userId").is(userId));
		if (!org.apache.commons.lang.StringUtils.isBlank(userName)) {
			mongoTemplate.updateMulti(query, Update.update("userName", userName), Feed.class);
		}
		if (!org.apache.commons.lang.StringUtils.isBlank(headUrl)) {
			mongoTemplate.updateMulti(query, Update.update("userHeadUrl", headUrl), Feed.class);
		}
	}
	
	/**
	 * 用户设置朋友圈权限
	 * @param userId
	 * @param friendId
	 * @param priv 0 关闭权限 1 开启权限
	 * @param direct 0 设置我的朋友圈不给好友看权限  1 设置不看好友的朋友圈权限
	 * @return 
	 * 设置不给好友看时候直接删除好友动态内我的朋友圈
	 * 设置不看好友的 在我的朋友圈 删除好友动态
	 */
	public int setFeedAuth(long userId,long friendId,int priv,int direct){
		String field="";
		if (direct==0) {
			field="ufeedPriv";
		}else{
			field="feedPriv";
		}
		String sql="update im_friend set %s = %d where userId = ? and friendId = ?";
		if (this.updateBySql(String.format(sql, field,priv), userId,friendId)>0) {
			if (priv==0) {
				Query q=new Query();
				if (direct==0) {
					q=Query.query(Criteria.where("belongUserId").is(friendId).and("userId").is(userId));
				}else{
					q=Query.query(Criteria.where("belongUserId").is(userId).and("userId").is(friendId));
				}
				mongoTemplate.remove(q, Feed.class);
			}
			return 1;
		}
		return 0;
	}
	
	public HashMap<String, Object> getFeedAuth(long userId,long friendId){
		Object res = this.queryForObjectBySql("select ufeedPriv as feedPrivUser,feedPriv as feedPrivFriend,isBlack,remark from im_friend where userId=? and friendId=?", userId,friendId);
		HashMap<String, Object> result=new HashMap<>();
		if (res==null) {
			result.put("feedPrivUser", "0");
			result.put("feedPrivFriend", "0");
			result.put("isBlack", "0");
			result.put("remark", "");
			return result;
		}
		JSONObject json=JSON.parseObject(JSON.toJSONString(res, SerializerFeature.WriteNullStringAsEmpty));		
		result.put("feedPrivUser",json.getOrDefault("feedPrivUser", "0"));
		result.put("feedPrivFriend", json.getOrDefault("feedPrivFriend", "0"));
		result.put("isBlack", json.getOrDefault("isBlack", "0"));
		result.put("remark", json.getOrDefault("remark", ""));
		return result;
	}
	
	public MongoPage searchFeed(long userId,long year,int month,int pageNo){
		MongoPage page = new MongoPage();
		page.setPageNo(pageNo);
		//获取当前月第一天：
        Calendar c = Calendar.getInstance();     
        c.set(Calendar.YEAR,Integer.parseInt(String.valueOf(year)));
        c.set(Calendar.MONTH,month-1);
        c.set(Calendar.DAY_OF_MONTH, 1);
        SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
        String date=formatter.format(c.getTime());
		String string=date+" 00:00:00";
		SimpleDateFormat beginFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Long beginTime=(long) 0;Long endTime=(long) 0;
		try {
			beginTime=beginFormat.parse(string).getTime();
			c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
	    	date=formatter.format(c.getTime());
	    	string=date+" 00:00:00";
	    	endTime=beginFormat.parse(string).getTime()+864000;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Set<Long> blackid = userService.getUserBlackList(userId);
		Query query = Query.query(Criteria.where("belongUserId").is(userId).and("userId").nin(blackid).and("createTime").gte(beginTime).lt(endTime));
		// 查询总数
		int count = (int) mongoTemplate.count(query, Feed.class);
		page.setTotalCount(count);

		// 排序
		query.with(new Sort(Direction.DESC, "createTime"));
		query.skip(page.getSkip()).limit(page.getPageSize());

		List<Feed> datas = mongoTemplate.find(query, Feed.class);
		page.setList(datas);
		return page;
	}
	
	@SuppressWarnings("unchecked")
	public ImFeedGift sendGift(Long userId,Long destId,Long feedId,String gift){
		ImFeedGift feedGift=new ImFeedGift();
		feedGift.setUserId(userId);
		feedGift.setDestId(destId);
		feedGift.setFeedId(feedId);
		feedGift.setContent(gift);
		this.save(feedGift);
		return feedGift;
	}
	
	public Page myGift(Long userId,int pageNo){
		Page page=new Page();
		page.setPageNo(pageNo);
		page.setPageSize(20);
		page.setOrderBy("createTime");
		page.setOrderType(OrderType.desc);
		page=this.queryForListBySql("select fg.*,IFNULL(u.name,u.nickName) name,u.headUrl from im_feed_gift fg left join im_user u on u.id=fg.userId where fg.destId=?", page, userId);
		return page;
	}
	
	public Feed delFeedComment(long userId,long commentId){
		ImFeedComment dbComment=(ImFeedComment) this.queryForObject("from ImFeedComment where id=? and user_id=?", commentId,userId);
		if (dbComment!=null) {
			Query q=Query.query(Criteria.where("id").is(commentId));
			this.updateBySql("delete from im_feed_comment where id=? and user_id=?", commentId,userId);
			mongoTemplate.remove(q, FeedComment.class);
			Update update = new Update();
			Query q1=Query.query(Criteria.where("feedId").is(dbComment.getImFeed().getId()));
			List<Feed> feeds=mongoTemplate.find(q1, Feed.class);	
			if(feeds!=null&&feeds.size()>0)
				for(Feed feed:feeds){
					List<FeedComment> comments=feed.getImFeedComments();
					if(comments!=null&&comments.size()>0)
					for(FeedComment comment:comments){
						if(comment.getUserId()==userId&&comment.getId()==commentId){
							mongoTemplate.updateMulti(q1,update.pull("imFeedComments", comment), Feed.class);
						}
					}
				}	
			return this.getOneFeed(dbComment.getImFeed().getId(), userId);
		}
		return null;
	}
}
