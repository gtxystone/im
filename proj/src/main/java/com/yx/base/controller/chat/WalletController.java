package com.yx.base.controller.chat;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
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

import com.alibaba.fastjson.JSON;
import com.framework.util.RedisUtil;
import com.github.wxpay.sdk.WXPayUtil;
import com.yx.base.extendmodel.ImUserBankcard;
import com.yx.base.extendmodel.ImUserOrders;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.bank.BankService;
import com.yx.base.service.bank.BankUtil;
import com.yx.base.service.login.ReadyService;
import com.yx.base.service.user.OrderService;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.service.wallet.WxPayService;
import com.yx.base.util.YxUtil;

@Controller
@RequestMapping("/wallet")
@CrossOrigin(origins ="*")
public class WalletController {

	@Autowired
	private WalletService walletService;
	
	@Autowired
	private BankService bankService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ReadyService readyService;
	
	@Autowired
	private OrderService orderService;
	

	/**
	 * 获取余额
	 * 
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@RequestMapping("/getBalance")
	@ResponseBody
	public ResponseData getBalance(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId) {
		if (userId > 0) {
			BigDecimal balance = walletService.getBalance(userId);
			return YxUtil.createSuccessData(balance);
		}

		return YxUtil.createFail("发生异常");
	}

	/**
	 * 获取账单
	 * 
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@RequestMapping("/getWalletHistory")
	@ResponseBody
	public ResponseData getWalletHistory(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId) {
		if (userId > 0) {
			List<ImWalletHistory> history = walletService.getWalletHistory(userId);
			return YxUtil.createSuccessData(history);
		}
		return YxUtil.createFail("发生异常");
	}

	/**
	 * 充值
	 * 
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@RequestMapping("/recharge")
	@ResponseBody
	public ResponseData recharge(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "0.00") BigDecimal amount) {
		if (userId > 0 && amount.compareTo(new BigDecimal("0.00")) > 0) {
			return YxUtil.createSuccessData(walletService.recharge(userId, amount));
		}
		return YxUtil.createFail("充值失败");
	}
	
	/**
	 * 提现
	 * 
	 * @param request
	 * @param response
	 * @param userId
	 * @return
	 */
	@RequestMapping("/withdraw")
	@ResponseBody
	public ResponseData withdraw(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "0.00") BigDecimal amount) {
		if (userId > 0 && amount.compareTo(new BigDecimal("0.00")) > 0) {
			return YxUtil.createSuccessData(walletService.withdraw(userId, amount));
		}
		return YxUtil.createFail("提现失败");
	}

	/**
	 * 创建支付订单
	 * @param request
	 * @param response
	 * @param userId
	 * @param amount
	 * @param body
	 * @param subject
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/createRechargeOrder")
	@ResponseBody
	public ResponseData createRechargeOrder(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "0") long userId, @RequestParam(defaultValue = "0.00") BigDecimal amount,
			@RequestParam(defaultValue = "") String body, @RequestParam(defaultValue = "") String subject, @RequestParam(defaultValue = "alipay") String type , @RequestParam(defaultValue = "0") Long orderType)
					throws IOException {
		if (StringUtils.isBlank(subject)) {
			return YxUtil.createFail("订单创建失败");
		}
		if (amount.compareTo(new BigDecimal("0.00")) <= 0) {
			return YxUtil.createFail("金额格式不正确");
		}
		if (userId > 0) {
			HashMap<String, Object> data=new HashMap<>();
			if (type.toLowerCase().compareTo("alipay")==0) {
				data = walletService.alipayOrder(userId, amount, body, subject,orderType);
			}else if (type.toLowerCase().compareTo("wxpay")==0) {
				data = walletService.wxPayOrder(userId, amount, body, subject, request,orderType);
			}
			if (data.get("outTradeNo")==null) {
				return YxUtil.createFail("订单创建失败");
			}
			if (StringUtils.isBlank(data.get("orderString").toString())) {
				return YxUtil.createFail("订单创建失败");
			}
			return YxUtil.createSuccessData(data);
		}
		return YxUtil.createFail("订单创建失败");
	}
	
	@RequestMapping("/alipayNotify")
	@ResponseBody
	public String alipayNotify(HttpServletRequest request, HttpServletResponse response) throws IOException{
		
		walletService.alipayNotify(request);
		return "SUCCESS";
	}
	
	@RequestMapping("/wxpayNotify")
	@ResponseBody
	public void wxpayNotify(HttpServletRequest request, HttpServletResponse response){
		try {
			request.setCharacterEncoding("UTF-8");  
		    response.setCharacterEncoding("UTF-8");  
		    response.setContentType("text/html;charset=UTF-8");  
		    response.setHeader("Access-Control-Allow-Origin", "*");   
		    InputStream in=request.getInputStream();  
		    ByteArrayOutputStream out=new ByteArrayOutputStream();  
		    byte[] buffer =new byte[1024];  
		    int len=0;  
		    while((len=in.read(buffer))!=-1){  
		        out.write(buffer, 0, len);  
		    }  
		    out.close();  
		    in.close();  
		    String msgxml=new String(out.toByteArray(),"utf-8");//xml数据  
		    Map<String, String> map =new HashMap<>();
			try {
				map = WXPayUtil.xmlToMap(msgxml);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}  
//			"transaction_id":"4008372001201709111437393153",
//		    "nonce_str":"04300c2443a64d5d8fc2f24a5d19d2fd",
//		    "bank_type":"CFT",
//		    "openid":"o9w1ExHeQ3Wt9gKPI5Ahg5e7_ehE",
//		    "sign":"EC061D2DB13C85CCBC6B17D88C7008BAB4A14E9719E4E3823E581F7DEC4236A6",
//		    "fee_type":"CNY",
//		    "mch_id":"1487285792",
//		    "cash_fee":"1",
//		    "out_trade_no":"20170911001000300008542531",
//		    "appid":"wxd44bd36b209c1bc9",
//		    "total_fee":"1",
//		    "trade_type":"APP",
//		    "result_code":"SUCCESS",
//		    "time_end":"20170911085623",
//		    "is_subscribe":"N",
//		    "return_code":"SUCCESS"
			
			
			
//			RedisUtil.hset("wxpayNotify", System.currentTimeMillis()+"", JSON.toJSONString(map));
		    String result_code=(String) map.get("result_code");  
		    String out_trade_no  = (String) map.get("out_trade_no");  
		    String total_fee  = (String) map.get("total_fee");  
		    String sign  = (String) map.get("sign");  
		    Double amount=new Double(total_fee)/100;//获取订单金额  
		    String attach= (String) map.get("attach");  
		    String sn=out_trade_no.split("\\|")[0];//获取订单编号  
//		    Long memberid=Long.valueOf(attach);    
		    ImUserOrders order=orderService.getOrderBySn(sn, "wxpay");  
		    if(result_code.equals("SUCCESS")&&order!=null){ 
		    	while (RedisUtil.hget("wxpayNotify", out_trade_no) != null) {
		    		System.out.println("该订单正在处理中");
		    		Thread.sleep(10000);
				}
		    	RedisUtil.hset("wxpayNotify", out_trade_no, JSON.toJSONString(map));
		    	//验证签名  
		        map.remove("sign");
		        WxPayService wxPayService =new WxPayService();
		        String endsign = wxPayService.signData(map);  
		        if(sign.equals(endsign)){//验证签名是否正确  官方签名工具地址：https://pay.weixin.qq.com/wiki/tools/signverify/   
		            if(order.getStatus()==0){  
		                try{//处理自己的业务逻辑 
		                	if (orderService.wxOrderNotify(order, map)) {
		                		RedisUtil.hdel("wxpayNotify", out_trade_no);
		                		response.getWriter().write(wxPayService.setXml("SUCCESS", "OK"));    //告诉微信已经收到通知了  
							}
		                }catch(Exception e){  
		                	RedisUtil.hset("wxpayError", out_trade_no, "微信支付异步通知异常,requstData="+JSON.toJSONString(map));
		                    System.out.println("微信支付异步通知异常");  
		                }  
		            }else if(order.getStatus()==1){  
		                response.getWriter().write(wxPayService.setXml("SUCCESS", "OK"));    //告诉微信已经收到通知了  
		            }  
		      
		        }else {
		        	RedisUtil.hset("wxpayError", out_trade_no, "签名验证失败,requstData="+JSON.toJSONString(map));
		        	System.out.println("签名验证失败");
				}  
		    }else {
		    	RedisUtil.hset("wxpayError", out_trade_no, "订单信息查询失败,requstData="+JSON.toJSONString(map));
			}
		} catch (Exception e) {
			// TODO: handle exception
			RedisUtil.hset("wxpayError", String.valueOf(System.currentTimeMillis()), e.getMessage());
		}
	}
	
	@RequestMapping("/cancelOrder")
	@ResponseBody
	public ResponseData cancelOrder(HttpServletRequest request, HttpServletResponse response,@RequestParam(defaultValue = "") String outTradeNo,@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "alipay") String type) throws IOException{
		walletService.cancelOrder(outTradeNo, type,userId);
		return YxUtil.createSimpleSuccess("支付已取消");
	}
	
	@RequestMapping("/getCardList")
	@ResponseBody
	public ResponseData getCardList(@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "") String province) throws IOException{
		return YxUtil.createSuccessData(bankService.getCardList(userId));
	}
	
	@RequestMapping("/bindingCard")
	@ResponseBody
	public ResponseData bindingCard(@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "") String cardNo) throws IOException{
		if (userId>0) {
			if (StringUtils.isBlank(cardNo)||!BankUtil.checkBankCard(cardNo)) {
				return YxUtil.createFail("请输入正确卡号");
			}
			ImUserBankcard exits=(ImUserBankcard) bankService.queryForObject("from ImUserBankcard where userId=? and cardNo=?", userId,cardNo);
			if (exits!=null) {
				return YxUtil.createFail("已绑定过该卡");
			}
			return YxUtil.createSuccessData(bankService.bandingCard(userId, cardNo,BankUtil.getname(cardNo)));
		}
		return YxUtil.createFail("绑定失败");
	}
	
	@RequestMapping("/dissCard")
	@ResponseBody
	public ResponseData dissCard(@RequestParam(defaultValue = "0") long userId,@RequestParam(defaultValue = "0") long cardId ) throws IOException{
		if (userId>0&&cardId>0) {
			ImUserBankcard exits=(ImUserBankcard) bankService.queryForObject("from ImUserBankcard where userId=? and id=?", userId,cardId);
			if (exits==null) {
				return YxUtil.createFail("解绑失败");
			}
			if (bankService.dissCard(userId, cardId)>0) {
				return YxUtil.createSimpleSuccess("解绑成功");
			}
			return YxUtil.createFail("解绑失败");
		}
		return YxUtil.createFail("解绑失败");
	}
	
}
