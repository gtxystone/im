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
@Table(name = "im_user_orders", catalog = "imdb")
public class ImUserOrders implements Serializable {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5979491239245649945L;
	private Long id;
	private Long userId;
	private BigDecimal amount;
	private int status;
	private String content;
	private String outTradeNo;
	private String outString;
	private String notifyString;
	private String createTime;
	private String updateTime;
	private String plat;
	private Long historyid;
	private String sessionid;
	private Long type;

	@Column(name = "historyid")
	public Long getHistoryid() {
		return historyid;
	}

	public void setHistoryid(Long historyid) {
		this.historyid = historyid;
	}

	@Column(name = "sessionid")
	public String getSessionid() {
		return sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	public ImUserOrders() {
	}

	public ImUserOrders(Long userId, BigDecimal amount, int status,String outTradeNo, String createTime, String updateTime, String outString, String notifyString, String content) {
		this.userId = userId;
		this.amount = amount;
		this.status = status;
		this.setContent(content);
		this.outTradeNo = outTradeNo;
		this.outString = outString;
		this.notifyString = notifyString;
		this.createTime = createTime;
		this.updateTime = updateTime;
	}

	@Column(name = "amount")
	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	@Column(name = "status")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Column(name = "outTradeNo")
	public String getOutTradeNo() {
		return outTradeNo;
	}

	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}

	@Column(name = "outString")
	public String getOutString() {
		return outString;
	}

	public void setOutString(String outString) {
		this.outString = outString;
	}

	@Column(name = "notifyString")
	public String getNotifyString() {
		return notifyString;
	}

	public void setNotifyString(String notifyString) {
		this.notifyString = notifyString;
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

	@Column(name = "plat")
	public String getPlat() {
		return plat;
	}

	public void setPlat(String plat) {
		this.plat = plat;
	}

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "type")
	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}
	
}
