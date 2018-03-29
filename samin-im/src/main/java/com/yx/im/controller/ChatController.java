package com.yx.im.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.yx.base.parameter.ResponseData;
import com.yx.base.service.chat.ChatService;
import com.yx.base.util.YxUtil;

@RestController
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	
	@RequestMapping(value="/notifyOffline")
	@ResponseBody
	public ResponseData notifyOffline(@RequestParam(defaultValue="0")long userId) {
		chatService.pushMessage();
		return YxUtil.createSimpleSuccess("下线成功");
	}
	@RequestMapping({"/notifyNew"})
	@ResponseBody
	 public ResponseData notifyNew()
	 {
	   this.chatService.pushMessage();
	   System.out.println("检测发送的消息是");
	   return YxUtil.createSimpleSuccess("转发成功");
	 }
}
