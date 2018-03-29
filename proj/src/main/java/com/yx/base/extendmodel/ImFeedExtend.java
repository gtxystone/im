package com.yx.base.extendmodel;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.yx.base.model.*;

@Entity
@Table(name = "im_feed", catalog = "imdb")
public class ImFeedExtend implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5300591444876752575L;

	private Long id;
	private String feedText;
	private String feedImgs;
	private Long userId;
	private String userName;
	private String userHeadUrl;
	private Long createTime;
	private Integer status;
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Set<ImFeedPraise> imFeedPraises = new HashSet(0);
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Set<ImFeedComment> imFeedComments = new HashSet(0);

	private String lng;

	private String lat;

	private int priv;

	private String address;

	private String at;
	
	private String uids;
	
	private String feedVideo;
	
	private String ext;

	public ImFeedExtend() {
	}

	public ImFeedExtend(String feedText, String feedImgs, Long userId, String userName, String userHeadUrl,
			Long createTime, Integer status, Set<ImFeedPraise> imFeedPraises, Set<ImFeedComment> imFeedComments) {
		this.feedText = feedText;
		this.feedImgs = feedImgs;
		this.userId = userId;
		this.userName = userName;
		this.userHeadUrl = userHeadUrl;
		this.createTime = createTime;
		this.status = status;
		this.imFeedPraises = imFeedPraises;
		this.imFeedComments = imFeedComments;
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

	@Column(name = "feed_text", length = 65535)
	public String getFeedText() {
		return this.feedText;
	}

	public void setFeedText(String feedText) {
		this.feedText = feedText;
	}

	@Column(name = "feed_imgs", length = 65535)
	public String getFeedImgs() {
		return this.feedImgs;
	}

	public void setFeedImgs(String feedImgs) {
		this.feedImgs = feedImgs;
	}

	@Column(name = "user_id")
	public Long getUserId() {
		return this.userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Column(name = "user_name")
	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Column(name = "user_head_url")
	public String getUserHeadUrl() {
		return this.userHeadUrl;
	}

	public void setUserHeadUrl(String userHeadUrl) {
		this.userHeadUrl = userHeadUrl;
	}

	@Column(name = "create_time")
	public Long getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	@Column(name = "status")
	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "imFeed")
	public Set<ImFeedPraise> getImFeedPraises() {
		return this.imFeedPraises;
	}

	public void setImFeedPraises(Set<ImFeedPraise> imFeedPraises) {
		this.imFeedPraises = imFeedPraises;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "imFeed")
	public Set<ImFeedComment> getImFeedComments() {
		return this.imFeedComments;
	}

	public void setImFeedComments(Set<ImFeedComment> imFeedComments) {
		this.imFeedComments = imFeedComments;
	}

	@Column(name = "lng")
	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	@Column(name = "lat")
	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	@Column(name = "priv")
	public int getPriv() {
		return priv;
	}

	public void setPriv(int priv) {
		this.priv = priv;
	}

	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "at")
	public String getAt() {
		return at;
	}

	public void setAt(String at) {
		this.at = at;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Column(name = "uids")
	public String getUids() {
		return uids;
	}

	public void setUids(String uids) {
		this.uids = uids;
	}

	@Column(name = "feed_video")
	public String getFeedVideo() {
		return feedVideo;
	}

	public void setFeedVideo(String feedVideo) {
		this.feedVideo = feedVideo;
	}

	@Column(name = "ext")
	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}
}
