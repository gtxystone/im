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
@Table(name = "im_group_config", catalog = "imdb")
public class ImGroupConfig implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6297547808316438962L;
	private Long id;
	private int level;
	private Long expire;
	private BigDecimal fee;

	public ImGroupConfig() {
	}

	public ImGroupConfig( int level, Long expire,BigDecimal fee) {
		this.level = level;
		this.expire = expire;
		this.fee=fee;
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

	@Column(name = "level")
	public int getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "expire")
	public Long getExpire() {
		return expire;
	}

	public void setExpire(Long expire) {
		this.expire = expire;
	}
	
	@Column(name = "fee")
	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}
	
	
	
}
