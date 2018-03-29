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
@Table(name = "im_rock_record", catalog = "imdb")
public class ImRockRecord implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6333729553363566369L;
	private Long id;
	private Long userId;
	private Long destId;
	private String name;
	private String headUrl;
	private String sign;
	private String sex;
	private double distance;
	private int isdelete;
	private String createTime;
	private String updateTime;

	public ImRockRecord() {
	}

	public ImRockRecord(Long userId, Long destId,String name,String headUrl,String sign,String sex,Double distance,int isdelete,String createtime,String updateTime) {
		this.userId = userId;
		this.destId=destId;
		this.name = name;
		this.headUrl=headUrl;
		this.sign=sign;
		this.sex=sex;
		this.distance=distance;
		this.isdelete=isdelete;
		this.createTime=createtime;
		this.updateTime=updateTime;
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

	@Column(name = "destId")
	public Long getDestId() {
		return destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
	}

	@Column(name = "headUrl")
	public String getHeadUrl() {
		return headUrl;
	}

	public void setHeadUrl(String headUrl) {
		this.headUrl = headUrl;
	}

	@Column(name = "sign")
	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	@Column(name = "sex")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "distance")
	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	@Column(name = "isdelete")
	public int getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(int isdelete) {
		this.isdelete = isdelete;
	}

	@Column(name = "createTime")
	public String getCreateTime() {
		return createTime;
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
	
	
	
}
