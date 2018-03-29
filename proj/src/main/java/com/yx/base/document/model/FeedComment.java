package com.yx.base.document.model;
// Generated 2017-6-7 12:07:25 by Hibernate Tools 5.2.1.Final

import javax.persistence.Id;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "ImFeedComment")
public class FeedComment implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -793563416005206935L;
	
	@Id
	private Long id;
	private Long userId;
	private String userName;
	private String userHeadUrl;
	private Long replyUserId;
	private String replyUserName;
	private String replyUserHeadUrl;
	private String commentText;
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
	public String getReplyUserName() {
		return replyUserName;
	}
	public void setReplyUserName(String replyUserName) {
		this.replyUserName = replyUserName;
	}
	public String getReplyUserHeadUrl() {
		return replyUserHeadUrl;
	}
	public void setReplyUserHeadUrl(String replyUserHeadUrl) {
		this.replyUserHeadUrl = replyUserHeadUrl;
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
	public Long getReplyUserId() {
		return replyUserId;
	}
	public void setReplyUserId(Long replyUserId) {
		this.replyUserId = replyUserId;
	}
	public String getCommentText() {
		return commentText;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public Long getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}


}
