package com.yx.base.controller.chat;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
@RequestMapping(value="/upload")
@CrossOrigin(origins ="*")
public class TestUploadController {

	@SuppressWarnings("deprecation")
	@RequestMapping("/chengdu")
	@ResponseBody
	public String uploadImage(HttpServletRequest request, @RequestParam CommonsMultipartFile[] fileUpload,
			ModelMap model) throws Exception {
		String fileName = "";
		if (fileUpload != null && fileUpload.length > 0) {
			for (CommonsMultipartFile aFile : fileUpload) {
				fileName = "/temp/" + System.currentTimeMillis() + "_" + aFile.getOriginalFilename();
				if (!aFile.getOriginalFilename().equals("")) {
					aFile.transferTo(new File(request.getRealPath("/") + fileName));
					System.out.println("保存成功！");
				}
			}
		}

		return "不知道有没有成都两字，开发中";
	}
}
