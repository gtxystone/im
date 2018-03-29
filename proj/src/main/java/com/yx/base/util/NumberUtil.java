package com.yx.base.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 * 
 * @author shine
 * 靓号生成器
 */
public class NumberUtil {

	private String number;
	
	private Set<String> vipNumber=new HashSet<>();

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
}
