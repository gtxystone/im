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
@Table(name="im_transform", catalog="imdb")
public class ImTransForm
  implements Serializable
{
  /**
	 * 
	 */
	private static final long serialVersionUID = -3042887202809546980L;
private Long id;
  private long userId;
  private long destId;
  private BigDecimal amount;
  private String msg;
  private int status;
  private long sendTime;
  private Long confirmTime;
  private Long groupId;
  
  public ImTransForm() {}
  
  public ImTransForm(long userId, long destId, BigDecimal amount, int status, long sendTime,long groupId)
  {
    this.userId = userId;
    this.destId = destId;
    this.amount = amount;
    this.status = status;
    this.sendTime = sendTime;
    this.groupId=groupId;
  }
  
  public ImTransForm(long userId, long destId, BigDecimal amount, String msg, int status, long sendTime, Long confirmTime)
  {
    this.userId = userId;
    this.destId = destId;
    this.amount = amount;
    this.msg = msg;
    this.status = status;
    this.sendTime = sendTime;
    this.confirmTime = confirmTime;
  }
  
  @Id
  @GeneratedValue(strategy=GenerationType.IDENTITY)
  @Column(name="id", unique=true, nullable=false)
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long id)
  {
    this.id = id;
  }
  
  @Column(name="userId", nullable=false)
  public long getUserId()
  {
    return this.userId;
  }
  
  public void setUserId(long userId)
  {
    this.userId = userId;
  }
  
  @Column(name="destId", nullable=false)
  public long getDestId()
  {
    return this.destId;
  }
  
  public void setDestId(long destId)
  {
    this.destId = destId;
  }
  
  @Column(name="amount", nullable=false, precision=10)
  public BigDecimal getAmount()
  {
    return this.amount;
  }
  
  public void setAmount(BigDecimal amount)
  {
    this.amount = amount;
  }
  
  @Column(name="msg")
  public String getMsg()
  {
    return this.msg;
  }
  
  public void setMsg(String msg)
  {
    this.msg = msg;
  }
  
  @Column(name="status", nullable=false)
  public int getStatus()
  {
    return this.status;
  }
  
  public void setStatus(int status)
  {
    this.status = status;
  }
  
  @Column(name="sendTime", nullable=false)
  public long getSendTime()
  {
    return this.sendTime;
  }
  
  public void setSendTime(long sendTime)
  {
    this.sendTime = sendTime;
  }
  
  @Column(name="confirmTime")
  public Long getConfirmTime()
  {
    return this.confirmTime;
  }
  
  public void setConfirmTime(Long confirmTime)
  {
    this.confirmTime = confirmTime;
  }
  
  @Column(name="groupId")
  public long getGroupId()
  {
    return this.groupId;
  }
  
  public void setGroupId(long groupId)
  {
    this.groupId = groupId;
  }
}
