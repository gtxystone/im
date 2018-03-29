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
@Table(name = "im_sys_config", catalog = "imdb")
public class ImSysConfig implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8440654194774389832L;
	private Long id;
	private String _key;
	private String _value;
	private int status;

	public ImSysConfig() {
	}

	public ImSysConfig( String _key, String _value, int status) {
		this._key = _key;
		this._value = _value;
		this.status = status;
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

	@Column(name = "_key")
	public String get_key() {
		return _key;
	}

	public void set_key(String _key) {
		this._key = _key;
	}

	@Column(name = "_value")
	public String get_value() {
		return _value;
	}

	public void set_value(String _value) {
		this._value = _value;
	}

	@Column(name = "status")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
}
