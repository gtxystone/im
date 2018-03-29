package com.yx.base.controller.chat;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanMap;
import org.apache.commons.lang.ObjectUtils.Null;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.framework.model.Page;
import com.yx.base.document.model.Feed;
import com.yx.base.document.model.MongoPage;
import com.yx.base.extendmodel.ImFeedExtend;
import com.yx.base.model.ImFeed;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.feed.FeedService;
import com.yx.base.service.user.UserService;
import com.yx.base.util.YxUtil;

@Controller
@RequestMapping("/feed")
public class FeedController {

	@Autowired
	private FeedService feedService;
	
	@RequestMapping("/changeBackImage")
	@ResponseBody
	public ResponseData changeBackImage(@RequestParam(defaultValue = "0")long userId,
			@RequestParam(defaultValue = "")String imgUrl){
		int rows=feedService.updateBySql("update im_user set feedBackImage=? where id=?", imgUrl,userId);		
		if(rows>0){
			return YxUtil.createSimpleSuccess("更新背景成功");
		}
		return YxUtil.createFail("更新背景失败");
	}
	
	@RequestMapping("/getBackImage")
	@ResponseBody
	public ResponseData getBackImage(@RequestParam(defaultValue = "0")long userId){
		Object feedBackImage=feedService.queryForValueBySql("select IFNULL(feedBackImage,'') feedBackImage from im_user where id=? ", userId);		
		if(feedBackImage!=null){
			return YxUtil.createSuccessData(feedBackImage);
		}
		return YxUtil.createFail("未找到用户");
	}
	
	@RequestMapping("/getFeedAlbum")
	@ResponseBody
	public ResponseData getFeedAlbum(@RequestParam(defaultValue = "0")long userId,@RequestParam(defaultValue = "0")long destId){
		Object o=feedService.queryForObjectBySql("select GROUP_CONCAT(feed_imgs) album from(select feed_imgs  from im_feed where user_id=? and feed_imgs <>'' ORDER BY create_time desc LIMIT 3)a", destId);
		if(o!=null){
			return YxUtil.createSuccessData(o);
		}
		return YxUtil.getResponse(0, "没有相册数据");
	}

	@RequestMapping("/addFeed")
	@ResponseBody
	public ResponseData addFeed(HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue = "")String images, @RequestParam(defaultValue = "")String text,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="") String lat,@RequestParam(defaultValue="") String lng,@RequestParam(defaultValue="") String address,
			@RequestParam(defaultValue="0") int priv,@RequestParam(defaultValue="") String at,@RequestParam(defaultValue="") String uids,@RequestParam(defaultValue="") String video,@RequestParam(defaultValue="") String ext) {
		ImFeedExtend feed = feedService.addFeed(images, text, userId, lat, lng, address, priv, at, uids,video,ext);
		if (userId > 0 && feed != null && feed.getId() > 0) {
			Feed feed2=feedService.getOneFeed(feed.getId(), userId);
			return YxUtil.createSuccessData(feed2);
		} else {
			return YxUtil.createFail("发布失败");
		}
	}

	@RequestMapping("/addFeedComment")
	@ResponseBody
	public ResponseData addFeedComment(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long feedId, String text, @RequestParam(defaultValue = "0")long userId,
			@RequestParam(defaultValue = "0") long replyId) {
		if (feedId == 0 || userId == 0 || text == null) {
			return YxUtil.createFail("评论发布失败");
		}
		feedService.addFeedComment(feedId, text, userId, replyId);
		return YxUtil.createSimpleSuccess("评论发布成功");
	}

	@RequestMapping("/addFeedPraise")
	@ResponseBody
	public ResponseData addFeedPraise(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long feedId, @RequestParam(defaultValue = "0") long userId) {
		if(feedId==0||userId==0){
			return YxUtil.createFail("发布失败");
		}
		feedService.addFeedPraise(feedId, userId);
		return YxUtil.createSimpleSuccess("赞发布成功");
	}
	
	@RequestMapping("/canclePraise")
	@ResponseBody
	public ResponseData canclePraise(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long feedId, @RequestParam(defaultValue = "0") long userId) {
		if(feedId==0||userId==0){
			return YxUtil.createFail("取消赞失败");
		}
		feedService.canclePraise(feedId, userId);
		return YxUtil.createSimpleSuccess("取消赞成功");
	}
	
	@RequestMapping("/deleteFeed")
	@ResponseBody
	public ResponseData deleteFeed(@RequestParam(defaultValue = "0") long feedId, @RequestParam(defaultValue = "0") long userId) {
		if(feedId==0||userId==0){
			return YxUtil.createFail("删除失败，参数不正确");
		}
		feedService.deleteFeed(feedId, userId);
		return YxUtil.createSimpleSuccess("删除成功");
	}
	
	@RequestMapping("/getOneFeed")
	@ResponseBody
	public ResponseData getOneFeed(@RequestParam(defaultValue = "0") long feedId, @RequestParam(defaultValue = "0") long userId) {
		if(feedId==0||userId==0){
			return YxUtil.createFail("失败，参数不正确");
		}
		Feed feed=feedService.getOneFeed(feedId, userId);
		if (feed==null) {
			return YxUtil.createSimpleSuccess(0,"该动态已被删除");
		}
		return YxUtil.createSuccessData(feed);
	}

	@RequestMapping("/getFeed")
	@ResponseBody
	public ResponseData getFeed(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "1") int pageNo) {

		MongoPage page = feedService.getFeed(userId, pageNo);
		return YxUtil.createSuccessData(page);
	}
	
	@RequestMapping("/getMyFeed")
	@ResponseBody
	public ResponseData getMyFeed(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "1") int pageNo) {
		MongoPage page=new MongoPage();
		page.setPageNo(pageNo);
		page = feedService.getMyFeed(userId, page);		
		return YxUtil.createSuccessData(page);
	}
	
	@RequestMapping("/getFriendFeed")
	@ResponseBody
	public ResponseData getFriendFeed(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long friendId, @RequestParam(defaultValue = "1") int pageNo) {
		Page page=new Page();
		page.setPageNo(pageNo);
		page = feedService.pagedQuery("from ImFeed where userId=? order by createTime desc", page, friendId);
		List list=page.getList();
		for(Object o:list){
			ImFeed f=(ImFeed)o;
			f.setImFeedComments(new HashSet());
			f.setImFeedPraises(new HashSet());
		}
		return YxUtil.createSuccessData(page);
	}
	
	@RequestMapping("/setFeedAuth")
	@ResponseBody
	public ResponseData setFeedAuth(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long friendId, @RequestParam(defaultValue = "1") int priv, @RequestParam(defaultValue = "0") int direct) {
		if (feedService.setFeedAuth(userId, friendId, priv, direct)>0) {
			return YxUtil.createSimpleSuccess("设置成功");
		}
		return YxUtil.createFail("设置失败");
	}
	
	@RequestMapping("/searchFeed")
	@ResponseBody
	public ResponseData searchFeed(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long year, @RequestParam(defaultValue = "0") int month, @RequestParam(defaultValue = "1") int pageNo){
		MongoPage page=feedService.searchFeed(userId, year, month, pageNo);
		return YxUtil.createSuccessData(page);
	}
	
	@RequestMapping("/sendFeedGift")
	@ResponseBody
	public ResponseData sendFeedGift(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long destId, @RequestParam(defaultValue = "0") long feedId, @RequestParam(defaultValue = "") String gift){
		if (userId>0&&destId>0&&feedId>0&&!StringUtils.isBlank(gift)) {
			return YxUtil.createSuccessData(feedService.sendGift(userId, destId, feedId, gift));
		}
		return YxUtil.createFail("赠送失败");
	}
	
	@RequestMapping("/myGift")
	@ResponseBody
	public ResponseData myGift(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="1") int pageNo){
		if (userId>0) {
			return YxUtil.createSuccessData(feedService.myGift(userId, pageNo));
		}
		return YxUtil.createFail("赠送失败");
	}
	
	@RequestMapping("/delFeedComment")
	@ResponseBody
	public ResponseData delFeedComment(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="0") long commentId){
		if (userId>0&&commentId>0) {
			Feed feed=feedService.delFeedComment(userId, commentId);
			if (feed!=null) {
				return YxUtil.createSuccessData(feed);
			}
			return YxUtil.createFail("删除失败");
		}
		return YxUtil.createFail("删除失败");
	}

}
