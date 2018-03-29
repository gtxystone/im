package com.yx.base.service.chat;


import org.springframework.stereotype.Service;

import com.corundumstudio.socketio.AuthorizationListener;
import com.corundumstudio.socketio.HandshakeData;
import com.framework.util.Utils;

@Service
public class IMAuthorizationListener implements AuthorizationListener{

	@Override
	public boolean isAuthorized(HandshakeData data) {
		String userId=Utils.decrypt(data.getSingleUrlParam("token"));
		String deviceStr=data.getSingleUrlParam("device");
		if(userId!=null&&deviceStr!=null){
			return true;
		}
		
		System.out.println("验证失败，拒绝连接");
		return false;
	}

}
