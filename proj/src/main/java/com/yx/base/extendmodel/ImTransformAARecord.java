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
@Table(name = "im_transform_aa_record", catalog = "imdb")
public class ImTransformAARecord implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8942878973629919459L;
	private Long id;
	private Long userId;
	private Long destId;
	private BigDecimal amount;
	private Long createTime;
	
	
	

	public ImTransformAARecord() {
	}

	public ImTransformAARecord( Long createTime, Long userId, Long destId,BigDecimal amount) {
		this.userId = userId;
		this.destId = destId;
		this.createTime = createTime;
		this.amount=amount;
	}

	@Column(name = "userId")
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	@Column(name = "destId")
	public Long getDestId() {
		return destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
	}

	@Column(name = "amount")
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@Column(name = "createTime")
	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = System.currentTimeMillis();
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
