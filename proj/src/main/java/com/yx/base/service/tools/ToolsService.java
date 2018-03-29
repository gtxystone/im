package com.yx.base.service.tools;

import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Service;

import com.framework.util.RedisUtil;

@Service
public class ToolsService {
	
	
	public void cleanIp(String excludeIp){
		Map<String, String> map=RedisUtil.hgetAll("user_ip");
		for(String key:map.keySet()){
			String dbip=RedisUtil.hget("user_ip", key);
			if(!dbip.equals(excludeIp)){
				RedisUtil.hdel("user_ip", key);
			}			
		}
	}
	
	 public static String getRandom(int len){  
	        Random rad=new Random();  
	 
//	        System.out.println((int)Math.pow(10, Double.parseDouble(len+"")));
	        String result  = rad.nextInt((int)Math.pow(10, Double.parseDouble(len+""))) +"";  
	  
	        if(result.length()<len){  
	            for (int i = result.length(); i < len; i++) {
	            	result = "0" + result;
				}  
	        }  
	        return result;  
	    } 
}
