package com.yx.base.util;
import java.io.IOException;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yx.base.nim.NimApi;
//import com.netease.nim.*;
import com.yx.base.service.common.imConfig;
public class NimService{
	
	@Autowired
	private static imConfig config;
	
	private static NimApi api;
	
	private static String decodeRes(String res){
		if (StringUtils.isBlank(res)) {
			return "";
		}
		JSONObject json=JSONObject.parseObject(res);
		if (json.get("code")==null) {
			return "";
		}
		String code=json.get("code").toString();
		if (code.equals(new String("200"))) {
			return res;
		}else{
			return "";
		}
	}
	
	public static String createUser(String accid, String name, String token){
		try {
			return decodeRes(api.createUser(accid, name, token)==null?"":api.createUser(accid, name, token));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			return "";
		}
	} 
	
	public static String updateToken(String accid){
		try {
			return decodeRes(api.updateToken(accid)==null?"":api.updateToken(accid));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			return "";
		}
	}
	
}
