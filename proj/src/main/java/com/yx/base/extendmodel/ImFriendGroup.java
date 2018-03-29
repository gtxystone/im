package com.yx.base.extendmodel;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "im_friend_group", catalog = "imdb")
public class ImFriendGroup implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8404692308140699215L;
	private Long id;
	private Long userId;
	private String name;
	private int sort;
	private Long createtime;
	private int isdefault;

	public ImFriendGroup() {
	}

	public ImFriendGroup(Long userId,String name, int sort, Long createtime,int isdefault) {
		this.userId = userId;
		this.name = name;
		this.sort=sort;
		this.createtime=createtime;
		this.isdefault=isdefault;
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

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "sort")
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	@Column(name = "createtime")
	public Long getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Long createtime) {
		this.createtime = createtime;
	}
	
	@Column(name = "isdefault")
	public int getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(int isdefault) {
		this.isdefault = isdefault;
	}
	
}
