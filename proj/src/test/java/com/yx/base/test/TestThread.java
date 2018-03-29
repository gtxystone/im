package com.yx.base.test;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import org.springframework.http.HttpEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSON;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

public class TestThread extends Thread{
	public static RestTemplate request=new RestTemplate();
	
	public static String httpRequest(String url,MultiValueMap<String,Object> dataMap){
		try {			 
			HttpEntity<Object> entity = new HttpEntity<Object>(dataMap);  	
			
			String body=request.postForObject(url, entity,String.class);
			System.out.println(body);
			entity=null;
			return body;
		} catch (RestClientException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public void run(){
		while(true){			
			try {
				/*String url="http://120.27.145.73/wmsMobile/chat/doLogin";				
				LinkedMultiValueMap dataMap = new LinkedMultiValueMap<String, Object>();  
				dataMap.add("mobile", "+8613558756061");
				dataMap.add("pwd", "96e79218965eb72c92a549dd5a330112");
				dataMap.add("device", "1");				
				
				String text=TestThread.httpRequest(url,dataMap);
				HashMap res=JSON.parseObject(text, HashMap.class);
				HashMap data=JSON.parseObject(res.get("data").toString(), HashMap.class);
								
				dataMap.clear();
				url="http://120.27.145.73/wmsMobile/chat/ready";
				dataMap.add("token", data.get("token").toString());
				TestThread.httpRequest(url,dataMap);*/
				
				
				String url="http://120.27.145.73/wmsMobile/chat/doLogin";	
				try {
					HttpResponse<String> html=Unirest.post(url)
							.field("mobile", "+8613558756061")
							.field("pwd", "96e79218965eb72c92a549dd5a330112")
							.field("device", "1")
							.asString();
					String text=html.getBody();
					//System.out.println(text);
					HashMap res=JSON.parseObject(text, HashMap.class);
					HashMap data=JSON.parseObject(res.get("data").toString(), HashMap.class);
					
					url="http://120.27.145.73/wmsMobile/chat/ready";
					text=Unirest.post(url)
					.field("token", data.get("token").toString())
					.asString().getBody();
					//System.out.println("2=="+text);
					
				} catch (UnirestException e) {
					e.printStackTrace();
				}
				
				Thread.sleep(200);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String args[]) throws UnsupportedEncodingException{
		for(int i=0;i<5000;i++){
			TestThread thread=new TestThread();
			thread.start();
		}		
	}
}
