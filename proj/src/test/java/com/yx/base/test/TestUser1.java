package com.yx.base.test;

import java.util.HashMap;

import org.junit.Test;

import com.alibaba.fastjson.JSON;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;




public class TestUser1 {
	
//	public static void main(String[] args) {
//		String url="http://127.0.0.1/chat/doLogin";	
//		try {
//			HttpResponse<String> html=Unirest.post(url)
//					.field("mobile", "+8613558756061")
//					.field("pwd", "96e79218965eb72c92a549dd5a330112")
//					.field("device", "1")
//					.asString();
//			String text=html.getBody();
//			System.out.println(text);
//			HashMap res=JSON.parseObject(text, HashMap.class);
//			HashMap data=JSON.parseObject(res.get("data").toString(), HashMap.class);
//			
//			
//			
//		} catch (UnirestException e) {
//			e.printStackTrace();
//		}
//	}
	
	@Test
	public void testRegister(){
		String url="http://127.0.0.1/chat/register";	
		try {
			HttpResponse<String> html=Unirest.post(url)
					.field("mobile", "+8613558756061")
					.field("pwd", "123456")
					.field("validateNum", "4121")
					.field("name", "测试")
					.asString();
			String text=html.getBody();
			System.out.println(text);
		} catch (UnirestException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGetValidateNum(){
		String url="http://127.0.0.1/chat/getValidateNum";	
		try {
			HttpResponse<String> html=Unirest.post(url)
					.field("mobile", "+8613558756061")
					.asString();
			String text=html.getBody();
			System.out.println(text);
		} catch (UnirestException e) {
			e.printStackTrace();
		}
	}

}
