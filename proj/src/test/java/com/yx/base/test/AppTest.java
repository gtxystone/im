package com.yx.base.test;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.framework.model.Page;
import com.framework.util.Utils;
import com.google.common.base.Joiner;
import com.google.common.primitives.Longs;
import com.yx.base.document.model.Feed;
import com.yx.base.document.model.MongoPage;
import com.yx.base.model.ImFeed;
import com.yx.base.model.ImFeedComment;
import com.yx.base.model.ImFeedPraise;
import com.yx.base.parameter.RobotMsg;
import com.yx.base.service.CommonService;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.feed.FeedService;
import com.yx.base.service.message.MessageService;
import com.yx.base.service.sms.SmsService;
import com.yx.base.service.tools.ToolsService;
import com.yx.base.service.user.UserService;
import com.yx.base.util.YxUtil;


@SuppressWarnings({ "unchecked", "unused" })
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:config/applicationContext.xml" })
public class AppTest {
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private CommonService commonService;
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MsgStoreAndNotify chatService;
	
	@Autowired
	private MessageService msgService;
	
	@Autowired
	private ToolsService tools;
	
	@Autowired
	private TaskExecutor executor;
	
	@Autowired
	MongoTemplate mongoTemplate;
	
	@Autowired
	private FeedService feedService;
	
	
	@Test
	public void geoTest(){
		/*List<Long> memberIds=new ArrayList<Long>();
		memberIds.add(17068l);
		memberIds.add(17126l);
		memberIds.add(17127l);
		memberIds.add(17107l);
		String idStr=Joiner.on(",").join(memberIds);
		List data=userService.queryForObjListBySql("select id,name,headUrl from im_user where id in("+idStr+") limit 10");
		System.out.println(data.size());
		
		System.out.println(userService.getFriendsIds(17068l));
		System.out.println(userService.getFriendsIds(170680l));*/
		
		/*Page page=new Page();
		page.setPageNo(1);
		
		page = feedService.pagedQuery("select new ImFeed(feedText, feedImgs, userId, userName, userHeadUrl,  createTime, status, new HashSet<ImFeedPraise>(), new HashSet<ImFeedComment>()) from ImFeed where userId=? order by createTime desc", page, 17068l);
		HashMap<String,Object> map=new HashMap<String,Object>();
		map.put("data", page);
		System.out.println(JSON.toJSONString(YxUtil.createSuccessData(page)));*/
		
		feedService.canclePraise(46l, 17122l);
	}
	
	@Test
	public void testcascode() {
		
		/*ImFeed feed=new ImFeed();
		feed.setCreateTime(System.currentTimeMillis());
		feed.setFeedImgs("img1,img2,img3");
		feed.setFeedText("my photo feed");
		feed.setUserId(1l);
		//commonService.save(feed);
*/		
		ImFeed feed=(ImFeed)commonService.queryForObject("from ImFeed where id=?", 1l);
		
		ImFeedComment comment=new ImFeedComment();
		comment.setCommentText(Utils.random(20));
		comment.setCreateTime(System.currentTimeMillis());
		comment.setImFeed(feed);
		comment.setUserId(2l);
		commonService.save(comment);
		
		ImFeed dbfeed=(ImFeed)commonService.queryForObject("from ImFeed where id=?", 1l);
		
		System.out.println(JSON.toJSONString(dbfeed));
		
		//commonService
	}
	
	private void insertComment(long feedId,ImFeedComment comment){
		ImFeed feed=(ImFeed)commonService.queryForObject("from ImFeed where id=?", feedId);
		if(feed!=null){
			
		}
	}
	
	@Test
	public void testfriend() {
		//userService.getFriends(17068l);
		//userService.getFriends(17122l);
		Set<byte[]> ids=userService.getMixFriend(17068l, 17122l,0);
		List<Feed> feeds=mongoTemplate.find(Query.query(Criteria.where("feedId").is(15).and("status").in(new Object[]{4,2})), Feed.class);
		System.out.println(feeds.size());
		for(byte[] idb:ids){
			System.out.println(Longs.fromByteArray(idb));
		}
	}
	
	@Test
	public void testmongo() {
		//feedService.addFeed("11,222,33", "dynamic", 17068l);
		//feedService.addFeedComment(15l, Utils.random(10), 17122l, 0);
		//feedService.addFeedPraise(15l,17122l);
		MongoPage page=feedService.getFeed(17079l, 1);
		for(Object o:page.getList()){
			Feed feed=(Feed)o;
			System.out.println(JSON.toJSONString(feed));
		}
		
		/*List<UserFeedComment> comments = new ArrayList<UserFeedComment>();  
		UserFeedComment comments1=new UserFeedComment();
		comments1.setFeedCommentText("comment1");
		comments1.setId("1");
		comments1.setUserId(1l);
		
		UserFeedComment comments2=new UserFeedComment();
		comments2.setFeedCommentText("comment2");
		comments2.setId("2");
		comments2.setUserId(2l);
		
		comments.add(comments1);
		comments.add(comments2);
		//mongoTemplate.save(comments1);
		//mongoTemplate.save(comments2);
		
		UserFeed feed=new UserFeed();
		feed.setComments(comments);
		feed.setCreateTime(System.currentTimeMillis());
		feed.setFeedImages("http:///111,http://222");
		feed.setFeedText(" 我的动态");
		feed.setId("1");
		feed.setUserId(1l);*/
		
		//mongoTemplate.save(feed);

		
		
		//UserFeed f = mongoTemplate.findOne(Query.query(Criteria.where("id").is("1")), UserFeed.class);
		
		Update update =new Update();
		
		//mongoTemplate.updateFirst(Query.query(Criteria.where("id").is("1")), update.push("comments", comments1), UserFeed.class);
		
		//UserFeed f = mongoTemplate.findOne(Query.query(Criteria.where("id").is("1")), UserFeed.class);
		
		//System.out.println(JSON.toJSONString(f));
		
		/*ObjectId id=new ObjectId ();
		DB db = mongoTemplate.getDb();
		System.out.println(db);
		DBCollection s = mongoTemplate.getCollection("test");
		DBCursor c = s.find();
		while (c.hasNext()) {
			DBObject obj = c.next();
			System.out.println(obj);
		}*/
	}
	
	public static void main(String args[]) throws IOException{
		System.out.println(Utils.encrypt("101"));
	}
	
	@SuppressWarnings("rawtypes")
	@Test
	public void test3() throws IOException{
		long[] destIds={17068,17078,17079,17080,17081,17082,17083,17084,17085,17086};
		List<HashMap<String,Object>> list=userService.queryForObjListBySql("select id from im_user where id>17070");
		for(HashMap<String,Object> map:list){
			Long id=Long.parseLong(map.get("id").toString());
			for(long userId:destIds){
				userService.addFriend(userId, id, true);
			}
		}
		
	}
	
	
	@Test
	public void test4() throws IOException{		
		String robotContent=chatService.httpRequest("http://api.qingyunke.com/api.php?key=free&appid=0&msg=av");
		RobotMsg response=JSON.parseObject(robotContent, RobotMsg.class);
		if(response.getCode()==0){
			System.out.println(response.getContent());
		}else{
			System.out.println("你萌萌哒。。。");
		}
	}
	
	
	@Test
	public void test() throws SQLException{
		System.out.println(chatService.httpRequest("https://www.zhihu.com"));
	}
	
}
