package com.yx.base.extendmodel;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.yx.base.model.ImFeedComment;
import com.yx.base.model.ImFeedPraise;

@Entity
@Table(name = "im_group", catalog = "imdb")
public class ImGroupExtend implements Serializable{

	@Id
	@GeneratedValue
	private Long id;
	private String name;
	private String descriptions;
	private String detail;
	private String headUrl;
	private Long createrId;
	private Long createTime;
	private int joinStatus;
	private String question;
	private String answer;
	private int level;
	private Long expire;
	private BigDecimal fee;
	
	public ImGroupExtend() {}
	  
	public ImGroupExtend(String name, String descriptions, String detail, String headUrl, Long createrId, Long createTime,Integer joinStatus,String question,String answer,int level,Long expire,BigDecimal fee)
	  {
	    this.name = name;
	    this.descriptions = descriptions;
	    this.detail = detail;
	    this.headUrl = headUrl;
	    this.createrId = createrId;
	    this.createTime = createTime;
	    this.answer=answer;
	    this.question=question;
	    this.joinStatus=joinStatus;
	    this.level=level;
	    this.expire=expire;
	    this.fee=fee;
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
	  
	  @Column(name="name")
	  public String getName()
	  {
	    return this.name;
	  }
	  
	  public void setName(String name)
	  {
	    this.name = name;
	  }
	  
	  @Column(name="descriptions")
	  public String getDescriptions()
	  {
	    return this.descriptions;
	  }
	  
	  public void setDescriptions(String descriptions)
	  {
	    this.descriptions = descriptions;
	  }
	  
	  @Column(name="detail")
	  public String getDetail()
	  {
	    return this.detail;
	  }
	  
	  public void setDetail(String detail)
	  {
	    this.detail = detail;
	  }
	  
	  @Column(name="headUrl", length=65535)
	  public String getHeadUrl()
	  {
	    return this.headUrl;
	  }
	  
	  public void setHeadUrl(String headUrl)
	  {
	    this.headUrl = headUrl;
	  }
	  
	  @Column(name="createrId")
	  public Long getCreaterId()
	  {
	    return this.createrId;
	  }
	  
	  public void setCreaterId(Long createrId)
	  {
	    this.createrId = createrId;
	  }
	  
	  @Column(name="createTime")
	  public Long getCreateTime()
	  {
	    return this.createTime;
	  }
	  
	  public void setCreateTime(Long createTime)
	  {
	    this.createTime = createTime;
	  }

	  @Column(name="joinStatus")
	public int getJoinStatus() {
		return joinStatus;
	}

	public void setJoinStatus(int joinStatus) {
		this.joinStatus = joinStatus;
	}

	@Column(name="question")
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	@Column(name="answer")
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Column(name="level")
	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
	
	@Column(name="expire")
	  public Long getExpire()
	  {
	    return expire;
	  }
	  
	  public void setExpire(Long expire)
	  {
	    this.expire = expire;
	  }
	  @Column(name="fee")
	  public BigDecimal getFee()
	  {
	    return fee;
	  }
	  
	  public void setFee(BigDecimal fee)
	  {
	    this.fee = fee;
	  } 
	  
	  
	
}
