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
@Table(name = "im_transform_aa", catalog = "imdb")
public class ImTransformAA implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 924237038968649583L;
	private Long id;
	private Long userId;
	private Long destId;
	private String msg;
	private int destType;
	private BigDecimal totalAmount;
	private int status;
	private Long createTime;
	private Long updateTime;
	private int counts;

	public ImTransformAA() {
	}

	public ImTransformAA( Long createTime, Long updateTime, Long userId, String msg,int status,BigDecimal totalAmount, Long destId) {
		this.userId = userId;
		this.destId = destId;
		this.msg=msg;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.totalAmount=totalAmount;
		this.status=status;
	}

	@Column(name = "userId")
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Column(name = "createTime")
	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	@Column(name = "updateTime")
	public Long getUpdateTime(){
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
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

	@Column(name = "totalAmount")
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	@Column(name = "status")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Column(name = "destType")
	public int getDestType() {
		return destType;
	}

	public void setDestType(int destType) {
		this.destType = destType;
	}

	@Column(name = "counts")
	public int getCounts() {
		return counts;
	}

	public void setCounts(int counts) {
		this.counts = counts;
	}
	
	
	
	
	
	
}
