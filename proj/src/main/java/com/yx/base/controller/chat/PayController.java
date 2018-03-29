package com.yx.base.controller.chat;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.framework.util.RedisUtil;
import com.yx.base.model.ImUser;
import com.yx.base.parames.ImConstants;
import com.yx.base.parames.WalletConstants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.CommonService;
import com.yx.base.service.pay.PayService;
import com.yx.base.service.sms.SmsService;
import com.yx.base.service.user.OrderService;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.YxUtil;

import antlr.Utils;

@Controller
@RequestMapping("/pay")
@CrossOrigin(origins ="*")
public class PayController {
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private WalletService walletService;
	
	

	@RequestMapping("/setPayPwd")
	@ResponseBody
	public ResponseData setPayPwd(HttpServletRequest request, HttpServletResponse response, String pwd, long userId,@RequestParam(defaultValue="")String validateNum) throws IOException {
		ImUser user=userService.getImUser(userId);
		if(user==null||user.getId()<=0){
			return YxUtil.createFail("用户不存在");
		}
		
		if(!smsService.equalValidate(user.getMobile(), validateNum)){
			return YxUtil.createFail("验证码不正确！");
		}
		
		int code=payService.setPayPwd(userId, pwd);
		if(code==2){
			return YxUtil.createSimpleSuccess(code, "支付密码不能和上次相同");
		}		
		return YxUtil.createSimpleSuccess("支付密码设置完成");
	}
	
	@RequestMapping("/validatePayPwd")
	@ResponseBody
	public ResponseData validatePayPwd(HttpServletRequest request, HttpServletResponse response, String pwd, long userId) {
		if(payService.validatePayPwd(userId, pwd)){
			return YxUtil.createSuccessData("success");
		}
		return YxUtil.createFail("fail");
	}
	
	@RequestMapping("/getNumberType")
	@ResponseBody
	public ResponseData getNumberType(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="1") int device)  throws IOException{
		String sessid=request.getRequestedSessionId();
		if (!StringUtils.isBlank(sessid)) {
			RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"sessionid".getBytes(),sessid.getBytes());
			RedisUtil.expired(("RequestSessions|"+sessid).getBytes(), 1800);
		}else {
			HttpSession session = request.getSession();
			sessid=session.getId();
			RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"sessionid".getBytes(),sessid.getBytes());
			RedisUtil.expired(("RequestSessions|"+sessid).getBytes(), 1800);
		}
		HashMap<String, Object> data=new HashMap<>();
		data.put("sessid", sessid);
		data.put("types", payService.getNumberType());
		return YxUtil.createSuccessData(data);
	}
	
	@RequestMapping("/getVipNumber")
	@ResponseBody
	public ResponseData getVipNumber(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="") String sessid,@RequestParam(defaultValue="") String type)  throws IOException{
		if (!RedisUtil.exists(("RequestSessions|"+sessid).getBytes())) {
			RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"sessionid".getBytes(),sessid.getBytes());
			RedisUtil.expired(("RequestSessions|"+sessid).getBytes(), 1800);
		}
		HashMap<String, Object> data=new HashMap<>();
		data.put("numbers", payService.getVipNumber(type));
		return YxUtil.createSuccessData(data);
	}
	
	/**
	 * 创建购买靓号订单
	 * @param request
	 * @param response
	 * @param userId
	 * @param amount
	 * @param body
	 * @param subject
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/createNumberOrder")
	@ResponseBody
	public ResponseData createNumberOrder(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "0.00") BigDecimal amount,@RequestParam(defaultValue = "") String sessid,
			@RequestParam(defaultValue = "") String body, @RequestParam(defaultValue = "") String subject, @RequestParam(defaultValue = "alipay") String type, @RequestParam(defaultValue = "") String number,
			String mobile, String pwd,
			String validateNum, @RequestParam(defaultValue = "") String headUrl,
			@RequestParam(defaultValue = "") String name)
					throws IOException {
		if (StringUtils.isBlank(sessid)) {
			sessid=request.getSession().getId();
		}
		if (userId==0) {
			if (StringUtils.isBlank(name)){
				return YxUtil.createFail("昵称不能为空");
			}
			if (StringUtils.isBlank(mobile)){
				return YxUtil.createFail("手机号不能为空");
			}
			if (StringUtils.isBlank(pwd)){
				return YxUtil.createFail("密码不能为空");
			}
			List list = commonService.queryForObjListBySql("select * from im_user where mobile=?", mobile);
			if (list != null && list.size() > 0) {
				return YxUtil.createFail( "手机号码已存在");
			} 
			if (!smsService.equalValidate(mobile, validateNum)) {
				return YxUtil.createFail("验证码不正确");
			}
			if (pwd==null||pwd.length()==0||validateNum==null||validateNum.length()==0) {
				return YxUtil.createFail("有参数不正确");
			}
			HashMap<String, Object> user=new HashMap<>();
			user.put("mobile", mobile);
			user.put("headUrl", headUrl);
			user.put("pwd",com.framework.util.Utils.toMd5(pwd));
			user.put("name", name);
			RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"user".getBytes(),JSON.toJSONString(user).getBytes());
		}else {
			ImUser user=userService.getImUser(userId);
			Object imNumber = commonService.queryForValueBySql("select imNumber from im_user where id=?", userId);
			if (imNumber!=null&&!StringUtils.isBlank(imNumber.toString())) {
				return YxUtil.createFail("您已经绑定IM号了");
			}
			
			RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"user".getBytes(),JSON.toJSONString(user).getBytes());
		}
		if (StringUtils.isBlank(number)) {
			return YxUtil.createFail("请选择购买号码");
		}
		if (payService.checkNumber(number)) {
			return YxUtil.createFail("您手慢了，该号码已被注册");
		}
		if (RedisUtil.hget(ImConstants.IM_NUMBER_KEY, number)!=null) {
			return YxUtil.createFail("服务器繁忙，请稍后重试");
		}
		RedisUtil.hset(ImConstants.IM_NUMBER_KEY, number,String.valueOf(System.currentTimeMillis()));
		RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),"number".getBytes(),number.getBytes());
		if (StringUtils.isBlank(subject)) {
			return YxUtil.createFail("订单创建失败");
		}
		if (amount.compareTo(new BigDecimal("0.00")) <= 0) {
			return YxUtil.createFail("金额格式不正确");
		}
		HashMap<String, Object> data=new HashMap<>();
		if (type.toLowerCase().compareTo("alipay")==0) {
			data = walletService.alipayOrder(sessid, amount, body, subject);
		}else if (type.toLowerCase().compareTo("wxpay")==0) {
			data = walletService.wxPayOrder(sessid, amount, body, subject, request);
		}
		if (data.get("outTradeNo")==null) {
			return YxUtil.createFail("订单创建失败");
		}
		if (StringUtils.isBlank(data.get("orderString").toString())) {
			return YxUtil.createFail("订单创建失败");
		}
		return YxUtil.createSuccessData(data);
	}
	
	
	@RequestMapping("/checkNumber")
	@ResponseBody
	public ResponseData checkNumber(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue="") String sessid,@RequestParam(defaultValue="") String number)  throws IOException{
		if (payService.checkNumber(number)) {
			return YxUtil.createSimpleSuccess("注册成功");
		}
		return YxUtil.createFail("帐号注册中");
	}
}
