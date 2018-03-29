package com.yx.base.extendmodel;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 打招呼消息
 * 日期：2018年3月5日 下午3:23:23
 *
 * 作者：zss
 *
 * Copyright (c) 2015-2018 huiwork.com All rights reserved.
 */
@Entity
@Table(name = "im_rock_message", catalog = "imdb")
public class ImRockMessage implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6333729553363566369L;
	private Long id;
	private Long userId;
	private Long destId;
	private String msg;
	private Long pid;
	private Long addTime;
	private String createTime;

	public ImRockMessage() {
	}

	public ImRockMessage(Long userId, Long destId,String msg,Long pid,Long addTime,String createtime) {
		this.userId = userId;
		this.destId=destId;
		this.msg = msg;
		this.pid=pid;
		this.addTime=addTime;
		this.createTime=createtime;
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
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Column(name = "createTime")
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.createTime = (createTime==null?format.format(System.currentTimeMillis()):createTime);
	}

	@Column(name = "destId")
	public Long getDestId() {
		return destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
	}

	@Column(name = "msg")
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Column(name = "pid")
	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	@Column(name = "addTime")
	public Long getAddTime() {
		return addTime;
	}

	public void setAddTime(Long addTime) {
		this.addTime = addTime;
	}
	
}
