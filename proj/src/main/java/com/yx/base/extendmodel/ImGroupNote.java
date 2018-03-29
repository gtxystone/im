package com.yx.base.extendmodel;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "im_group_note", catalog = "imdb")
public class ImGroupNote implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 982376514442079693L;
	private Long id;
	private Long userId;
	private Long groupId;
	private String content;
	private String title;
	private String createTime;
	private String updateTime;

	public ImGroupNote() {
	}

	public ImGroupNote(Long userId, Long groupId, String content, String createTime, String title) {
		this.userId = userId;
		this.groupId = groupId;
		this.content = content;
		this.createTime = createTime;
		this.title = title;
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

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getGroupId() {
		return groupId;
	}

	@Column(name = "groupId")
	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}

	public String getTitle() {
		return title;
	}

	@Column(name = "title")
	public void setTitle(String title) {
		this.title = title;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	@Column(name = "updateTime")
	public void setUpdateTime(String updateTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.updateTime = (updateTime==null?format.format(System.currentTimeMillis()):updateTime);
	}
	
}
