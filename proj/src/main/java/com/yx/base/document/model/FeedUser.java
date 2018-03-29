package com.yx.base.document.model;
// Generated 2017-6-7 12:07:25 by Hibernate Tools 5.2.1.Final

import javax.persistence.Id;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "ImFeedUser")
public class FeedUser implements java.io.Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6083209733155141935L;
	private Long userId;
	private String userName;
	private String userHeadUrl;
	private Long feedId;
	
	
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

	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getFeedId() {
		return feedId;
	}
	public void setFeedId(Long feedId) {
		this.feedId = feedId;
	}


}
