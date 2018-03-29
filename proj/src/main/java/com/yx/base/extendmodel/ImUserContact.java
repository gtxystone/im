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
@Table(name = "im_user_contact", catalog = "imdb")
public class ImUserContact implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1039714089074492557L;
	private Long id;
	private Long userId;
	private String phone;
	private String header;
	private String markName;
	private String createTime;
	private String updateTime;

	public ImUserContact() {
	}

	public ImUserContact(Long userId, String phone, String header,String markName, String createTime, String updateTime) {
		this.userId = userId;
		this.phone = phone;
		this.header = header;
		this.markName = markName;
		this.createTime = createTime;
		this.updateTime = updateTime;
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

	public String getUpdateTime() {
		return updateTime;
	}

	@Column(name = "updateTime")
	public void setUpdateTime(String updateTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.updateTime = (updateTime==null?format.format(System.currentTimeMillis()):updateTime);
	}

	public String getPhone() {
		return phone;
	}

	@Column(name = "phone")
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHeader() {
		return header;
	}

	@Column(name = "header")
	public void setHeader(String header) {
		this.header = header;
	}

	public String getMarkName() {
		return markName;
	}

	@Column(name = "markName")
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	
}
