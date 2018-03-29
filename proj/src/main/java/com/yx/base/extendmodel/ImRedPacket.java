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
@Table(name = "im_redpacket", catalog = "imdb")
public class ImRedPacket implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1714752262073152293L;
	private Long id;
	private Long userId;
	private Integer redPacketCount;
	private BigDecimal redPacketAmount;
	private String redPacketContent;
	private Integer destType;
	private Long destId;
	private Integer redPacketType;
	private Long sendTime;
	private Long finishTime;
	private Integer status;
	private String command;
	private String limituser;
	
	public ImRedPacket() {
	}

	public ImRedPacket(Long userId, Integer redPacketCount, BigDecimal redPacketAmount, String redPacketContent,
			Integer destType, Long destId, Integer redPacketType, Long sendTime, Long finishTime, Integer status,String command,String limit) {
		this.userId = userId;
		this.redPacketCount = redPacketCount;
		this.redPacketAmount = redPacketAmount;
		this.redPacketContent = redPacketContent;
		this.destType = destType;
		this.destId = destId;
		this.redPacketType = redPacketType;
		this.sendTime = sendTime;
		this.finishTime = finishTime;
		this.status = status;
		this.limituser=limit;
		this.command=command;
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

	@Column(name = "redPacketCount")
	public Integer getRedPacketCount() {
		return this.redPacketCount;
	}

	public void setRedPacketCount(Integer redPacketCount) {
		this.redPacketCount = redPacketCount;
	}

	@Column(name = "redPacketAmount", precision = 10)
	public BigDecimal getRedPacketAmount() {
		return this.redPacketAmount;
	}

	public void setRedPacketAmount(BigDecimal redPacketAmount) {
		this.redPacketAmount = redPacketAmount;
	}

	@Column(name = "redPacketContent", length = 65535)
	public String getRedPacketContent() {
		return this.redPacketContent;
	}

	public void setRedPacketContent(String redPacketContent) {
		this.redPacketContent = redPacketContent;
	}

	@Column(name = "destType")
	public Integer getDestType() {
		return this.destType;
	}

	public void setDestType(Integer destType) {
		this.destType = destType;
	}

	@Column(name = "destId")
	public Long getDestId() {
		return this.destId;
	}

	public void setDestId(Long destId) {
		this.destId = destId;
	}

	@Column(name = "redPacketType")
	public Integer getRedPacketType() {
		return this.redPacketType;
	}

	public void setRedPacketType(Integer redPacketType) {
		this.redPacketType = redPacketType;
	}

	@Column(name = "sendTime")
	public Long getSendTime() {
		return this.sendTime;
	}

	public void setSendTime(Long sendTime) {
		this.sendTime = sendTime;
	}

	@Column(name = "finishTime")
	public Long getFinishTime() {
		return this.finishTime;
	}

	public void setFinishTime(Long finishTime) {
		this.finishTime = finishTime;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "command")
	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}
	
	@Column(name = "limituser")
	public String getLimit() {
		return limituser;
	}

	public void setLimit(String limit) {
		this.limituser = limit;
	}
}
