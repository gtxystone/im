package com.yx.base.extendmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "im_bank_region", catalog = "imdb")
public class ImBankRegion implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 785177553612024402L;
	private Long id;
	private Long regionCode;
	private String regionName;
	private String regionLevel;
	private String regionBelong;
	private String regionProvince;

	@Column(name = "regionCode")
	public Long getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(Long regionCode) {
		this.regionCode = regionCode;
	}

	@Column(name = "regionName")
	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	@Column(name = "regionLevel")
	public String getRegionLevel() {
		return regionLevel;
	}

	public void setRegionLevel(String regionLevel) {
		this.regionLevel = regionLevel;
	}

	@Column(name = "regionBelong")
	public String getRegionBelong() {
		return regionBelong;
	}

	public void setRegionBelong(String regionBelong) {
		this.regionBelong = regionBelong;
	}

	@Column(name = "regionProvince")
	public String getRegionProvince() {
		return regionProvince;
	}

	public void setRegionProvince(String regionProvince) {
		this.regionProvince = regionProvince;
	}

	public ImBankRegion() {
	}

	public ImBankRegion(Long regionCode, String regionName, String regionLevel, String regionBelong, String regionProvince) {
		this.regionCode=regionCode;
		this.regionName=regionName;
		this.regionLevel=regionLevel;
		this.regionBelong=regionBelong;
		this.regionProvince=regionProvince;
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
