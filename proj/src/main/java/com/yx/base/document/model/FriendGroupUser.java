package com.yx.base.document.model;
// Generated 2017-6-7 12:07:25 by Hibernate Tools 5.2.1.Final

import javax.persistence.Id;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "ImFriendGroupUser")
public class FriendGroupUser implements java.io.Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6226188542947274413L;
	@Id
	private Long id;
	private Long userId;
	private Long groupId;
	private Long createTime;
	
	
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
