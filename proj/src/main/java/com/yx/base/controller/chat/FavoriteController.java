package com.yx.base.controller.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.framework.model.Page;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.favorite.FavoriteService;
import com.yx.base.util.YxUtil;

@RequestMapping("/favorite")
@Controller
public class FavoriteController {

	@Autowired
	private FavoriteService favoriteService;

	/**
	 * 
	 * @param userId
	 * @param category
	 * @param content
	 * @param srcId
	 * @param srcHeadUrl
	 * @return
	 */
	@RequestMapping("/addFavorite")
	@ResponseBody
	public ResponseData addFavorite(@RequestParam(defaultValue = "0") long userId,
			@RequestParam(defaultValue = "0") int category, @RequestParam(defaultValue = "") String content,
			@RequestParam(defaultValue = "0") long fromId, @RequestParam(defaultValue = "") String fromName,
			@RequestParam(defaultValue = "") String fromHeadUrl) {
		if (userId <= 0 || category <= 0 || fromId <= 0) {
			return YxUtil.createFail("收藏失败，参数不正确");
		}
		boolean result=favoriteService.addFavorite(userId, category, content, fromId, fromName, fromHeadUrl);
		if(result){
			return YxUtil.createSimpleSuccess("收藏成功");
		}else{
			return YxUtil.createFail("收藏失败，重复收藏");
		}		
	}
	
	

	@RequestMapping("/getFavorite")
	@ResponseBody
	public ResponseData getFavorite(long userId, @RequestParam(defaultValue = "1") int pageNo) {
		Page page = new Page();
		page.setPageNo(pageNo);
		page=favoriteService.getFavorite(userId, page);
		return YxUtil.createSuccessData(page);
	}
	
	@RequestMapping("/delFavorite")
	@ResponseBody
	public ResponseData delFavorite(@RequestParam(defaultValue = "0")long userId,@RequestParam(defaultValue = "0")long favoriteId){
		favoriteService.updateBySql("delete from im_favorite where id=?", favoriteId);
		return YxUtil.createSimpleSuccess("删除成功");
	}
}
