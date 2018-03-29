package com.yx.base.service.login;


import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;

import com.yx.base.service.group.GroupService;


/**
 * 日期：2018年1月11日 上午9:01:51
 *
 * 作者：zss
 *
 * Copyright (c) 2015-2018 huiwork.com All rights reserved.
 */
public class GroupThread implements Runnable{

	@Autowired
	private GroupService groupService;
	
	private Long userId;
	
	public GroupThread(Long userId)  
    {  
        this.userId=userId;  
    } 
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			if (this.userId!=null) {
				groupService.checkUserGroup(this.userId);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
