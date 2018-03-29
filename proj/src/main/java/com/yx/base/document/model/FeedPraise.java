package com.yx.base.document.model;
// Generated 2017-6-7 12:07:25 by Hibernate Tools 5.2.1.Final

import javax.persistence.Id;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "ImFeedPraise")
public class FeedPraise implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -622670060141948815L;
	@Id
	private Long id;
	private Long userId;
	private String userName;
	private String userHeadUrl;
	private Long createTime;
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserHeadUrl() {
		return userHeadUrl;
	}
	public void setUserHeadUrl(String userHeadUrl) {
		this.userHeadUrl = userHeadUrl;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}


}
