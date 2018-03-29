package com.yx.base.service.sms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.util.RedisUtil;
import com.yunpian.sdk.YunpianClient;
import com.yunpian.sdk.model.Result;
import com.yunpian.sdk.model.SmsSingleSend;
import com.yunpian.sdk.model.Template;
import com.yx.base.parameter.Constants;
import com.yx.base.service.CommonService;

@Service
public class SmsService {
	
	@Autowired
	private CommonService commonService;
	
	public boolean isExistsMobile(String mobile){
		Object user=commonService.queryForObjectBySql("from im_user where mobile=?", mobile);
		if(user!=null){
			return true;
		}
		return false;
	}

	public Integer sendSms(String mobile, String validateNum) {
		
		//云片平台的发送短信的key:8707ce354063488bb3378e87a03ff430
		YunpianClient clnt = new YunpianClient("8707ce354063488bb3378e87a03ff430").init();

		String text = "您的验证码是#code#。如非本人操作，请忽略本短信！";
		Map<String, String> tplParam = clnt.newParam(1);

//		if (mobile.startsWith("+1")) {
//			tplParam.put("tpl_id", "1689668");//  其它
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+81")) {
//			tplParam.put("tpl_id", "1689674");// 日本
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+82")) {
//			tplParam.put("tpl_id", "1689670");// 韩国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+86")) {
//			tplParam.put("tpl_id", "1687344");// 中国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else {
//			tplParam.put("tpl_id", "1687344");// 默认中国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		}
		if (mobile.startsWith("+86")) {
			tplParam.put("tpl_id", "2236076");// 中国
			Result<List<Template>> templates = clnt.tpl().get(tplParam);
			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
		}
		Map<String, String> param = clnt.newParam(5);
		param.put("mobile", mobile);
		param.put("text", text);

		Result<SmsSingleSend> r = clnt.sms().single_send(param);
		System.out.println("验证码："+validateNum);
		clnt.close();
		
		return r.getCode();
	}
	public Integer sendSms(String mobile, String validateNum,String app) {
		RedisUtil.expired(Constants.SMS_KEY.getBytes(), 60 * 30);
		RedisUtil.hset(Constants.SMS_KEY, mobile, validateNum);
		//云片平台的发送短信的key:8707ce354063488bb3378e87a03ff430
		YunpianClient clnt = new YunpianClient("8707ce354063488bb3378e87a03ff430").init();

		String text = "您的验证码是#code#。如非本人操作，请忽略本短信";
		Map<String, String> tplParam = clnt.newParam(1);
		
		if (mobile.startsWith("+86")) {
			tplParam.put("tpl_id", "2236076");// 中国
			Result<List<Template>> templates = clnt.tpl().get(tplParam);
			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
		}
		Map<String, String> param = clnt.newParam(5);
		param.put("mobile", mobile);
		param.put("text", text);

		Result<SmsSingleSend> r = clnt.sms().single_send(param);
		System.out.println("验证码："+validateNum);
		clnt.close();
		
		return r.getCode();
	}

	public boolean equalValidate(String mobile, String validateNum) {
		String num = RedisUtil.hget(Constants.SMS_KEY, mobile);
		if (num != null) {
			String numStr = String.valueOf(num);
			if (numStr.equals(validateNum)) {
				return true;
			}
		}

		return false;
	}

	public static void main(String args[]) throws Exception {
		YunpianClient clnt = new YunpianClient("8707ce354063488bb3378e87a03ff430").init();
		String mobile="+8615146503222";
		String validateNum="2222";
		String text = "您的验证码是#code#。如非本人操作，请忽略本短信";
		//String text = "测试测试";
		Map<String, String> tplParam = clnt.newParam(1);

//		if (mobile.startsWith("+1")) {
//			tplParam.put("tpl_id", "1689668");//  其它
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+81")) {
//			tplParam.put("tpl_id", "1689674");// 日本
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+82")) {
//			tplParam.put("tpl_id", "1689670");// 韩国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else if (mobile.startsWith("+86")) {
//			tplParam.put("tpl_id", "2236076");// 中国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		} else {
//			tplParam.put("tpl_id", "1687344");// 默认中国
//			Result<List<Template>> templates = clnt.tpl().get(tplParam);
//			text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);
//		}
		
		tplParam.put("tpl_id", "2236076");// 中国
		Result<List<Template>> templates = clnt.tpl().get(tplParam);
		text = templates.getData().get(0).getTpl_content().replace("#code#", validateNum);

		Map<String, String> param = clnt.newParam(2);
		param.put("mobile", mobile);
		param.put("text", text);

		Result<SmsSingleSend> r = clnt.sms().single_send(param);
		System.out.println(r.getCode());
		clnt.close();
	}
}
