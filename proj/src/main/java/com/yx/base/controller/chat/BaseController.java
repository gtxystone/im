package com.yx.base.controller.chat;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.framework.util.RedisUtil;
import com.framework.util.Utils;
import com.yx.base.model.ImVersion;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.CommonService;
import com.yx.base.service.chat.ChatConfig;
import com.yx.base.service.login.LoginService;
import com.yx.base.service.tools.ToolsService;
import com.yx.base.service.user.UserService;
import com.yx.base.util.YxUtil;

@SuppressWarnings("unchecked")
@Controller
@CrossOrigin(origins ="*")
public class BaseController {
	
	@Autowired
	private ToolsService toolsService;

	@Autowired
	private UserService userService;

	@Autowired
	private ChatConfig config;
	
	@Autowired
	private CommonService commonService;

	@RequestMapping("/exception")
	@ResponseBody
	public ResponseData exception(HttpServletRequest request, HttpServletResponse response) {
		return YxUtil.createFail("服务器异常");
	}

	@RequestMapping("/onlineUsers")	
	public void getOnlineUser(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		model.put("users", userService.getOnlineUserList());
	}

	@RequestMapping("/getVersion")
	@ResponseBody
	public ResponseData getVersion(@RequestParam(defaultValue = "1") int device,@RequestParam(defaultValue = "0.0.1") String curversion) {
		HashMap<String, Object> version = (HashMap<String, Object>) userService
				.queryForObjectBySql("select * from im_version where device=? order by id desc limit 0,1", device);
//		if (version==null) {
//			HashMap<String, Object> cur=new HashMap<>();
//			cur.put("versions", curversion);
//			cur.put("url", "");
//			cur.put("id", "");
//			return YxUtil.createSuccessData(cur);
//		}
		if (versionCompare(curversion, version.get("versions").toString())) {
			return YxUtil.createSimpleSuccess(version);
		}else{
			return YxUtil.createFail("已经是最新版本");
		}
	}
	
	@RequestMapping("/publishold")
	public String publish(HttpServletRequest request,@RequestParam(defaultValue = "1") int device,ModelMap model){
		HashMap<String, Object> version = (HashMap<String, Object>) userService
				.queryForObjectBySql("select * from im_version where device=? order by id desc limit 0,1", device);
		if(version==null){
			model.put("versions", "还未发布过版本");
		}else{
			model.put("versions", version.get("versions"));
		}
		
		return "publish";
	}
	
	
	@RequestMapping("/doPublish")
	public String doPublish(
			@RequestParam(defaultValue = "1") int device, String content, String versions,String url) {
		if(url==null||versions==null){
			return "redirect:/publish?device="+device;
		}
		ImVersion version=new ImVersion();
		version.setContent(content);
		version.setDevice(device);
		version.setUrl(url);
		version.setVersions(versions);
		userService.save(version);
		
		return "redirect:/publish?device="+device;
	}
	

	@RequestMapping("/uploadPublish")
	@ResponseBody
	public ResponseData publishVersion(HttpServletRequest request, MultipartFile myfile,
			@RequestParam(defaultValue = "1") int device, String content, String versions) {
		
		
		try {
			if (!myfile.isEmpty()) {
				String realPath = request.getSession().getServletContext().getRealPath("/upload");
				String fileName = System.currentTimeMillis() + "_" + myfile.getOriginalFilename();
				FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, fileName));

				return YxUtil.createSuccessData("http://"+config.getLocal()+request.getContextPath() + "/upload/" + fileName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return YxUtil.createFail("失败");
		
	}

	@RequestMapping("/uploadFile")
	@ResponseBody
	public String uploadFile(HttpServletRequest request) {
		try {

			byte file[] = Utils.getByteByStream(request.getInputStream(), request.getContentLength());

			String url = "/upload/capture.Png";
			String realPath = request.getSession().getServletContext().getRealPath("/");
			Utils.writeFile(file, realPath + url);
			return ("/imserver" + url);
		} catch (Exception e) {
			e.printStackTrace();
			return ("-1");
		}
	}

	@RequestMapping("/getMyIp")
	@ResponseBody
	public String getMyIp(HttpServletRequest request) {
		return LoginService.getClientIP(request);
	}

	@RequestMapping("/getServerIp")
	@ResponseBody
	public String getServerIp(HttpServletRequest request) {
		return config.getLocal();
	}
	
	@RequestMapping("/testFind")
	@ResponseBody
	public ResponseData testFind(HttpServletRequest request) {
		commonService.findUser();
		return YxUtil.createFail("失败");
	}
	
	@RequestMapping("/testQuery")
	@ResponseBody
	public ResponseData testQuery(HttpServletRequest request) {
		commonService.queryUser();
		return YxUtil.createFail("失败");
	}
	
	@RequestMapping("/cleanip")
	@ResponseBody
	public ResponseData cleanip(HttpServletRequest request,String excludeip) {
		toolsService.cleanIp(excludeip);		
		return YxUtil.createFail("ok");
	}
	@RequestMapping("/registDoc")
	public String registDoc(HttpServletRequest request, HttpServletResponse response,ModelMap model){
		HashMap<String, Object> document=userService.registDoc("regist");
		model.put("content",document==null?"":(String) document.get("content"));
		model.put("title",document==null?"":(String) document.get("title"));
		return "regist";
	}
	
	/**
	 * 版本比较
	 * @param currentVersion  当前版本号
	 * @param newVersion  新版本号
	 * @return
	 */
	private static boolean versionCompare(String currentVersion,String newVersion){
		String regx="^\\d+((\\.\\d+)?)+";
		boolean flag=false;
		if (!Pattern.matches(regx, currentVersion)||!Pattern.matches(regx, newVersion)) {
			flag=false;
		}else {
			String[] current=currentVersion.split("\\.");
			String[] newv=newVersion.split("\\.");
			for(int i=0;i<newv.length;i++){
				if (i>(current.length-1)) {
					flag=false;
					break;
				}
				if (Integer.parseInt(current[i])==Integer.parseInt(newv[i])) {
					continue;
				}else if (Integer.parseInt(current[i])>Integer.parseInt(newv[i])) {
					flag=false;
					break;
				}else {
					flag=true;
					break;
				}
				
			}
			
		}
		return flag;
	}

}
