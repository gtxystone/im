package com.yx.base.extendmodel;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.yx.base.model.ImUser;

@Entity
@Table(name = "im_feed_gift", catalog = "imdb")
public class ImFeedGift implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1179942283002602878L;
	private Long id;
	private Long userId;
	private Long destId;
	private Long feedId;
	private String content;
	private String createTime;
	private String updateTime;
	private ImUser sender;

	public ImFeedGift() {
	}

	public ImFeedGift(Long userId, Long destId, Long feedId, String content, String createTime) {
		this.userId = userId;
		this.destId = destId;
		this.feedId=feedId;
		this.content = content;
		this.createTime = createTime;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "userId")
	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Column(name = "createTime")
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.createTime = (createTime==null?format.format(System.currentTimeMillis()):createTime);
	}

	@Column(name = "giftContent")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "destId")
	public Long getDestId() {
		return destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
	}

	@Column(name = "feedId")
	public Long getFeedId() {
		return feedId;
	}

	public void setFeedId(Long feedId) {
		this.feedId = feedId;
	}

	@Column(name = "updateTime")
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.updateTime = (updateTime==null?format.format(System.currentTimeMillis()):updateTime);
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="userId",insertable=false,updatable=false)
	public ImUser getSender() {
		return sender;
	}

	public void setSender(ImUser sender) {
		this.sender = sender;
	}
	
}
