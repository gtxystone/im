package com.yx.base.service.favorite;

import org.springframework.stereotype.Service;

import com.framework.model.Page;
import com.framework.service.EntityServiceImpl;
import com.yx.base.model.ImFavorite;

@SuppressWarnings({"rawtypes","unchecked"})
@Service
public class FavoriteService extends EntityServiceImpl {


	public boolean addFavorite(long userId, int category, String content, long fromId,String fromName, String fromHeadUrl) {
		ImFavorite dbFavorite=(ImFavorite)this.queryForObject("from ImFavorite where fromId=? and content=? and category=? and userId=?", fromId,content,category,userId);
		if(dbFavorite!=null&&dbFavorite.getId()>0){
			return false;
		}
		ImFavorite favorite = new ImFavorite();
		favorite.setCategory(category);
		favorite.setContent(content);
		favorite.setCreateTime(System.currentTimeMillis());
		favorite.setFromHeadUrl(fromHeadUrl);
		favorite.setFromName(fromName);
		favorite.setUserId(userId);
		favorite.setFromId(fromId);
		save(favorite);
		return true;
	}

	public Page getFavorite(long userId, Page page) {
		page=this.pagedQuery("from ImFavorite where userId=? order by createTime desc", page, userId);
		return page;
	}

}
