package com.yx.base.controller.chat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yx.base.parameter.ResponseData;
import com.yx.base.util.YxUtil;

@Controller
@RequestMapping("/api")
@CrossOrigin(origins ="*")
public class ThirdController {
	
	@RequestMapping("/pushNotice")
	@ResponseBody
	public ResponseData pushNotice(HttpServletRequest request, HttpServletResponse response, long userId, String realName,
			String validateNum,String idNo,String mobile) {
		

		return YxUtil.createFail("各参数不能为空");
	}
}
