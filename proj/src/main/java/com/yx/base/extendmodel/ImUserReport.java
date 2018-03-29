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
@Table(name = "im_user_report", catalog = "imdb")
public class ImUserReport implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -9134095476017368820L;
	private Long id;
	private Long userId;
	private Long destId;
	private int status;
	private int destType;
	private String reportImgs;
	private String reportText;
	private String createTime;
	private String updateTime;

	public ImUserReport() {
	}

	public ImUserReport(Long userId, Long destId, int status, int destType, String reportImgs, String reportText, String createTime, String updateTime) {
		this.userId = userId;
		this.destId = destId;
		this.status = status;
		this.destType=destType;
		this.reportImgs = reportImgs;
		this.reportText = reportText;
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

	@Column(name = "destId")
	public Long getDestId() {
		return destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
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

	@Column(name = "report_imgs")
	public String getReportImgs() {
		return reportImgs;
	}

	public void setReportImgs(String reportImgs) {
		this.reportImgs = reportImgs;
	}

	@Column(name = "report_msg")
	public String getReportText() {
		return reportText;
	}

	
	public void setReportText(String reportText) {
		this.reportText = reportText;
	}
	
}
