package com.yx.base.controller.chat;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yx.base.extendmodel.ImTransForm;
import com.yx.base.model.ImTransform;
import com.yx.base.model.ImUser;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.group.GroupService;
import com.yx.base.service.pay.PayService;
import com.yx.base.service.transfer.TransferService;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.YxUtil;

@Controller
@RequestMapping("/transfer")
@CrossOrigin(origins = "*")
public class TransferController {

	@Autowired
	private TransferService transService;

	@Autowired
	private WalletService walletService;

	@Autowired
	private PayService payService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupService groupService;

	@RequestMapping("/createReceipt")
	@ResponseBody
	public ResponseData createReceipt(@RequestParam(defaultValue = "0") long userId,
			@RequestParam(defaultValue = "0") BigDecimal amount) throws IOException {
		if (userId <= 0) {
			return YxUtil.createFail("参数不正确");
		}
		ImUser user = (ImUser) userService.getImUser(userId);
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("receiptId", userId);
		data.put("qrcodeType", 1);
		data.put("receiptName", user.getName());
		data.put("receiptHeadUrl", user.getHeadUrl());
		data.put("amount", amount);

		return YxUtil.createSuccessData(data);
	}
	
	@RequestMapping("/createPayment")
	@ResponseBody
	public ResponseData createPayment(@RequestParam(defaultValue = "0") long userId,
			@RequestParam(defaultValue = "0") BigDecimal amount) throws IOException {
		if (userId <= 0) {
			return YxUtil.createFail("参数不正确");
		}
		ImUser user = (ImUser) userService.getImUser(userId);
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("paymentId", userId);
		data.put("qrcodeType", 2);
		data.put("paymentName", user.getName());
		data.put("paymentHeadUrl", user.getHeadUrl());
		data.put("amount", amount);

		return YxUtil.createSuccessData(data);
	}

	@RequestMapping("/postPayment")
	@ResponseBody
	public ResponseData postPayment(@RequestParam(defaultValue = "0") long userId,
			@RequestParam(defaultValue = "0") long destId, @RequestParam(defaultValue = "0") BigDecimal amount,
			@RequestParam(defaultValue = "") String payPwd) throws IOException {

		if (!walletService.validateBalance(userId, amount)) {
			return YxUtil.getResponse(3, "{'info':'金额不足'}");
		}		
		if(StringUtils.isNotBlank(payPwd)&&!payService.validatePayPwd(userId, payPwd)){
			return YxUtil.createFail("支付密码错误");
		}
		if (userId <= 0 || destId <= 0) {
			return YxUtil.createFail("参数不正确");
		}
		boolean result = transService.aATransfer(userId, destId, amount);
		if (result) {
			return YxUtil.createSimpleSuccess("付款成功");
		} else {
			return YxUtil.createFail("付款异常失败");
		}

	}

	@RequestMapping("/createTransfer")
	@ResponseBody
	public ResponseData createTransfer(HttpServletRequest request, HttpServletResponse response, String msg,
			BigDecimal amount, long userId, @RequestParam(defaultValue = "0") long destId, String payPwd,@RequestParam(defaultValue = "0") long groupId)
			throws IOException {
		if (!payService.validatePayPwd(userId, payPwd)) {
			return YxUtil.getResponse(2, "{'info':'支付密码不正确'}");
		}
		if (!walletService.validateBalance(userId, amount)) {
			return YxUtil.getResponse(3, "{'info':'金额不足'}");
		}
		if (StringUtils.isBlank(String.valueOf(groupId))||groupId==0) {
			ImTransform trans = transService.createTransfer(userId, destId, amount, msg);
			return YxUtil.createSuccessData(trans);
		}else {
			if (!groupService.checkGroupExits(groupId)) {
				return YxUtil.getResponse(4, "{'info':'群资料查询失败'}");
			}
			ImTransForm trans = transService.createTransfer(userId, destId, amount, msg,groupId);
			return YxUtil.createSuccessData(trans);
		}
	}

	@RequestMapping("/confimTransfer")
	@ResponseBody
	public ResponseData confimTransfer(HttpServletRequest request, HttpServletResponse response, long userId,
			@RequestParam(defaultValue = "0") long transId) throws IOException {
		boolean status = transService.updateConfimTransfer(transId, userId);
		if (status)
			return YxUtil.createSimpleSuccess("confirm..");
		else
			return YxUtil.createFail("fail..");
	}

	@RequestMapping("/viewTransfer")
	@ResponseBody
	public ResponseData viewTransfer(HttpServletRequest request, HttpServletResponse response, long userId,
			@RequestParam(defaultValue = "0") long transId) {
		ImTransform trans = transService.viewTransfer(transId, userId);
		return YxUtil.createSuccessData(trans);
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("/aaTrans")
	@ResponseBody
	public ResponseData aaTrans(@RequestParam(defaultValue = "0") long userId,int destType, long destId,String msg,BigDecimal totalAmount,int counts) throws IOException{
		if (userId>0&&destId>0&&counts>0) {
			if (counts>50) {
				return YxUtil.createFail("收款个数不能大于50");
			}
			if (totalAmount.doubleValue()<0.01*counts) {
				return YxUtil.createFail("单笔金额不得小于0.01元");
			}
			if (StringUtils.isBlank(msg)) {
				msg="有福同享，有难同当";
			}
			double amt=Math.ceil(totalAmount.doubleValue()*100/counts)/100;
			Map data=transService.aaTrans(userId,destType,destId,msg,totalAmount,counts,amt);
			if (data!=null) {
				return YxUtil.createSuccessData(data);
			}
			return YxUtil.createFail("发起失败");
		}
		return YxUtil.createFail("发起失败");
	}
	
	@RequestMapping("/aaTransPay")
	@ResponseBody
	public ResponseData aaTransPay(@RequestParam(defaultValue = "0") long userId,
			@RequestParam(defaultValue = "0") long destId, @RequestParam(defaultValue = "0") BigDecimal amount,
			@RequestParam(defaultValue = "") String payPwd,@RequestParam(defaultValue = "0") long transId) throws IOException{
		if (!walletService.validateBalance(userId, amount)) {
			return YxUtil.createFail("金额不足");
		}		
		if(StringUtils.isNotBlank(payPwd)&&!payService.validatePayPwd(userId, payPwd)){
			return YxUtil.createFail("支付密码错误");
		}
		if (userId <= 0 || destId <= 0||transId<=0) {
			return YxUtil.createFail("参数不正确");
		}
		if (userId>0&&destId>0&&transId>0) {
			return transService.aaTransPay(userId, destId, transId, amount);
		}
		return YxUtil.createFail("付款失败！");
	}
	
	@RequestMapping("/aaTransDetail")
	@ResponseBody
	public ResponseData aaTransDetail(@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long transId) throws IOException{
		return transService.aaTransDetail(userId, transId);
	}
}
