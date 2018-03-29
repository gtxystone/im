package com.yx.base.extendmodel;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "im_sam_number", catalog = "imdb")
public class ImSamNumber implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7470703913768424089L;
	private Long id;
	private Long userId;
	private String number;
	private BigDecimal price;
	private int used;
	
	
	@Column(name = "number")
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	@Column(name = "price")
	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	@Column(name = "used")
	public int getUsed() {
		return used;
	}

	public void setUsed(int used) {
		this.used = used;
	}

	private String createTime;
	private String updateTime;

	public ImSamNumber() {
	}

	public ImSamNumber( String createTime, String updateTime, Long userId, String cardNo, String number,int used,BigDecimal price) {
		this.userId = userId;
		this.used = used;
		this.number = number;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.price=price;
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

	@Column(name = "updateTime")
	public String getUpdateTime(){
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
