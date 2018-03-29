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
@Table(name = "im_document", catalog = "imdb")
public class ImDocument implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1668532443809385471L;
	private Long id;
	private String _key;
	private String title;
	private String content;
	private String auth;
	private String createTime;
	private String updateTime;

	public ImDocument() {
	}

	public ImDocument(String _key, String title, String content, String auth, String createTime,
			String updateTime) {
		this._key = _key;
		this.title = title;
		this.content = content;
		this.auth = auth;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	@Column(name = "_key")
	public String get_key() {
		return _key;
	}

	public void set_key(String _key) {
		this._key = _key;
	}

	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "auth")
	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	@Column(name = "createTime")
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.createTime = (createTime==null?format.format(System.currentTimeMillis()):createTime);
	}

	@Column(name = "updateTime")
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.updateTime = (updateTime==null?format.format(System.currentTimeMillis()):updateTime);
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
}
