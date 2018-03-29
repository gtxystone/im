package com.yx.base.service.wallet;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.internet.NewsAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.client.utils.URLEncodedUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.Feature;
import com.alibaba.fastjson.parser.ParserConfig;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.framework.util.Utils;
import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConstants;
import com.github.wxpay.sdk.WXPayUtil;
import com.yunpian.sdk.constant.Config;
import com.yunpian.sdk.model.User;
import com.yx.base.extendmodel.ImSamNumber;
import com.yx.base.extendmodel.ImUserOrders;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWallet;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.service.tools.ToolsService;
import com.yx.base.service.user.UserService;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service
public class WalletService extends EntityServiceImpl {
	
	@Autowired
	private UserService userService;

	/**
	 * 更新钱包
	 * 
	 * @param userId
	 * @param amount
	 * @param moneyDirect
	 * @return
	 */
	@Transactional
	public synchronized int updateWallet(long userId, BigDecimal amount, int moneyDirect) {
		this.initWallet(userId);
		int rows = 0;
		if (moneyDirect == 1) {
			rows = this.updateBySql("update im_wallet set money=money+? where userId=?", amount, userId);
		} else {
			rows = this.updateBySql("update im_wallet set money=money-? where userId=?", amount, userId);
		}
		return rows;
	}

	/**
	 * 返回余额
	 * 
	 * @param userId
	 * @return
	 */
	public BigDecimal getBalance(long userId) {
		this.initWallet(userId);
		ImWallet wallet = (ImWallet) this.queryForObject("from ImWallet where userId=?", userId);
		if (wallet != null) {
			return wallet.getMoney();
		}
		return new BigDecimal("0.00");
	}

	/**
	 * 获取账单
	 * 
	 * @param userId
	 * @return
	 */
	public List<ImWalletHistory> getWalletHistory(long userId) {
		this.initWallet(userId);
		List<ImWalletHistory> list = this.find("from ImWalletHistory where userId=?", userId);
		return list;
	}

	/**
	 * 判断余额是否充足
	 * 
	 * @param userId
	 * @param amount
	 * @return
	 */
	public boolean validateBalance(long userId, BigDecimal amount) {
		if (getBalance(userId).compareTo(amount) >= 0) {
			return true;
		}
		return false;
	}

	/**
	 * 充值
	 * 
	 * @param userId
	 * @param amount
	 * @return
	 */
	@Transactional
	public boolean recharge(long userId, BigDecimal amount) {
		this.initWallet(userId);
		int row = this.updateWallet(userId, amount, 1);
		if (row > 0) {
			// 保存到交易记录
			ImWalletHistory history = new ImWalletHistory();
			history.setAmount(amount);
			history.setDestId(userId);
			history.setMoneyDirect(1);
			history.setDestType(1);
			history.setMoneyType(MoneyConstants.BILLING_INCOME);
			history.setOccurTime(System.currentTimeMillis());
			history.setUserId(userId);					
			this.save(history);
			
			return true;
		}
		return false;
	}
	
	/**
	 * 提现
	 * 
	 * @param userId
	 * @param amount
	 * @return
	 */
	@Transactional
	public boolean withdraw(long userId, BigDecimal amount) {
		this.initWallet(userId);
		int row = this.updateWallet(userId, amount, -1);
		if (row > 0) {
			ImWalletHistory history = new ImWalletHistory();
			history.setAmount(amount);
			history.setDestId(userId);
			history.setMoneyDirect(-1);
			history.setDestType(1);
			history.setMoneyType(MoneyConstants.BILLING_OUTCOME);
			history.setOccurTime(System.currentTimeMillis());
			history.setUserId(userId);					
			this.save(history);
			
			return true;
		}
		return false;
	}
	
	public HashMap<String, Object> alipayOrder(long userId,BigDecimal amount,String body,String subject,Long orderType){
		HashMap<String, Object> data= new HashMap<>();
		try {
			Properties pro = new Properties();
			InputStream in = this.getClass().getResourceAsStream("/config/alipay.properties");
			pro.load(in);
			String date=new SimpleDateFormat("yyyyMMdd").format(new Date());
			String time=new SimpleDateFormat("HHmmss").format(new Date());
			String outtradeno = date+"00001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
			while(RedisUtil.hget(ImConstants.AIPAY_ORDER_KEY, outtradeno) != null){
				outtradeno = date+"00001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
			}
			ImUserOrders order=new ImUserOrders();
			order.setAmount(amount);
			order.setUserId(userId);
			order.setContent(body+" "+subject);
			order.setOutTradeNo(outtradeno);
			order.setNotifyString("");
			order.setPlat("alipay");
			order.setType(orderType);
			save(order);
//			System.out.println(outtradeno);
			//实例化客户端
			AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", pro.getProperty("APP_ID"),pro.getProperty("APP_PRIVATE_KEY"), "json", pro.getProperty("CHARSET"), pro.getProperty("ALIPAY_PUBLIC_KEY"), "RSA2");
			//实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
			AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
			//SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
			AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
			model.setBody(body);
			model.setSubject(subject);
			model.setOutTradeNo(outtradeno);
			model.setTimeoutExpress("30m");
			model.setTotalAmount(amount+"");
			model.setProductCode("QUICK_MSECURITY_PAY");
			request.setBizModel(model);
			request.setNotifyUrl("http://samim.huiwork.com:8080/wmsMobile/wallet/alipayNotify");		
			order.setOutString(JSON.toJSONString(model));
			String orderString="";
			try {
				RedisUtil.expired(ImConstants.AIPAY_ORDER_KEY.getBytes(), 60 * 30);
				RedisUtil.hset(ImConstants.AIPAY_ORDER_KEY, outtradeno, JSON.toJSONString(model));
			        //这里和普通的接口调用不同，使用的是sdkExecute
			        AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
			        orderString=response.getBody();
			    } catch (AlipayApiException e) {
			        e.printStackTrace();
			}
			data.put("orderString", orderString);
			data.put("outTradeNo", outtradeno);
			return data;
		} catch (IOException e) {
			// TODO: handle exception
			RedisUtil.lpush("logs", "alipayNotify"+new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date())+"-"+JSON.toJSONString(e));
		}
		return data;
	}
	
	public void alipayNotify(HttpServletRequest request) throws IOException{
//		RedisUtil.lpush("logs", System.currentTimeMillis()+"alipayNotify"+new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date())+"-"+JSON.toJSONString("调用一次"));
		Properties pro = new Properties();
		InputStream in = this.getClass().getResourceAsStream("/config/alipay.properties");
		pro.load(in);
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。
			//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}
		//切记alipaypublickey是支付宝的公钥，请去open.alipay.com对应应用下查看。
		//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
		boolean flag=false;
		// 交易状态  
	    String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8"); 
		
		
		try {
			flag = AlipaySignature.rsaCheckV1(params, pro.getProperty("ALIPAY_PUBLIC_KEY"), pro.getProperty("CHARSET"),"RSA2");
		} catch (AlipayApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			RedisUtil.lpush("alipayErrors", JSON.toJSONString(params));
		}
		if (flag) {
			if (params.get("out_trade_no")!=null&&RedisUtil.get((ImConstants.AIPAY_ORDER_SUCCUSS_KEY+"_"+params.get("out_trade_no")).getBytes()) == null) {				
				RedisUtil.set((ImConstants.AIPAY_ORDER_SUCCUSS_KEY+"_"+params.get("out_trade_no")).getBytes(), JSON.toJSONString(params).getBytes());
				RedisUtil.expired((ImConstants.AIPAY_ORDER_SUCCUSS_KEY+"_"+params.get("out_trade_no")).getBytes(), 60*5);
				ImUserOrders order=(ImUserOrders) this.queryForObject("from ImUserOrders where plat=? and outTradeNo=?","alipay", params.get("out_trade_no"));
				if (order!=null&&(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS"))) {
					order.setNotifyString(JSON.toJSONString(params));
					if (order.getStatus()!=1) {
						if (order.getType()==1) {
							ImSamNumber imSamNumber=(ImSamNumber) this.queryForObject("from ImSamNumber where number=?", new String(RedisUtil.hget(("RequestSessions|"+order.getSessionid()).getBytes(),"number".getBytes())));
							byte[] byteS=RedisUtil.hget(("RequestSessions|"+order.getSessionid()).getBytes(),"user".getBytes());
							Map<String, Object> map=JSONArray.parseObject(new String(byteS));
							ImUser user=new ImUser();
							if (map.get("id")!=null) {
								user=userService.getImUser(Long.parseLong(map.get("id").toString()));
							}else{
								user.setHeadUrl(map.get("headUrl").toString());
								user.setName(map.get("name").toString());
								user.setNickName(map.get("name").toString());
								user.setMobile(map.get("mobile").toString());
								user.setPwd(map.get("pwd").toString());
								user.setIsOnline(1);
								user.setSearchMobile(1);
								user.setNewNotification(0);
								user.setCreateTime(System.currentTimeMillis());
								user.setStatus(1);
								user.setIsAuth(0);
								user.setRecommandUserId(new Long(0));
								userService.createUser(user);
							}
							this.updateBySql("update im_user set imNumber=? where id=?", imSamNumber.getNumber(),user.getId());
							imSamNumber.setUsed(1);
							imSamNumber.setUserId(user.getId());
							order.setUserId(user.getId());
							// 保存到交易记录
							ImWalletHistory history = new ImWalletHistory();
							history.setAmount(order.getAmount());
							history.setDestId(order.getUserId());
							history.setMoneyDirect(0);
							history.setDestType(1);
							history.setContent("PayForAccount");
							history.setMoneyType(ImConstants.MONEY_TYPE_9);
							history.setOccurTime(System.currentTimeMillis());
							history.setUserId(order.getUserId());					
							this.save(history);
							order.setHistoryid(history.getId());
							order.setStatus(1);
							update(order);
							RedisUtil.delete(("RequestSessions|"+order.getSessionid()).getBytes());
							RedisUtil.hdel(ImConstants.IM_NUMBER_KEY.getBytes(), imSamNumber.getNumber().getBytes());
							RedisUtil.hdel(ImConstants.AIPAY_ORDER_KEY, order.getOutTradeNo());
							RedisUtil.delete((ImConstants.AIPAY_ORDER_SUCCUSS_KEY+"_"+params.get("out_trade_no")).getBytes());
						}else if (order.getType()==2) {
							
						}else{
							int row = this.updateWallet(order.getUserId(), order.getAmount(), 1);
							if (row > 0) {
								// 保存到交易记录
								ImWalletHistory history = new ImWalletHistory();
								history.setAmount(order.getAmount());
								history.setDestId(order.getUserId());
								history.setMoneyDirect(1);
								history.setDestType(1);
								history.setContent("RechargeForAccount");
								history.setMoneyType(MoneyConstants.BILLING_INCOME);
								history.setOccurTime(System.currentTimeMillis());
								history.setUserId(order.getUserId());					
								this.save(history);
								order.setHistoryid(history.getId());
								order.setStatus(1);
								update(order);
								RedisUtil.hdel(ImConstants.AIPAY_ORDER_KEY, order.getOutTradeNo());
								RedisUtil.delete((ImConstants.AIPAY_ORDER_SUCCUSS_KEY+"_"+params.get("out_trade_no")).getBytes());
							}
						}
						
					}
				}
			}
		}else{
			if (params.get("out_trade_no")!=null) {
				RedisUtil.lpush("alipayErrors", JSON.toJSONString(params));
			}
		}
	}
	
	public void cancelOrder(String outTradeNo,String plat,long userId){
		ImUserOrders order=(ImUserOrders) this.queryForObject("from ImUserOrders where plat=? and outTradeNo=? and userId=?",plat, outTradeNo,userId);
		if (order!=null) {
			if (order.getStatus()==0) {
				order.setStatus(2);
				update(order);
				RedisUtil.hdel(ImConstants.AIPAY_ORDER_KEY, outTradeNo);
			}
		}
	}

	
	
	public HashMap<String, Object> wxPayOrder(long userId,BigDecimal amount,String body,String subject,HttpServletRequest request,Long orderType){
		HashMap<String, Object> data= new HashMap<>();
		String date=new SimpleDateFormat("yyyyMMdd").format(new Date());
		String time=new SimpleDateFormat("HHmmss").format(new Date());
		String outtradeno = date+"001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
		while(RedisUtil.hget(ImConstants.WXPAY_ORDER_KEY, outtradeno) != null){
			outtradeno = date+"001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
		}
		ImUserOrders order=new ImUserOrders();
		order.setAmount(amount);
		order.setUserId(userId);
		order.setContent(body+" "+subject);
		order.setOutTradeNo(outtradeno);
		order.setNotifyString("");
		order.setPlat("wxpay");
		order.setType(orderType);
		save(order);
		String orderString="";
		try {
			WxPayService wxPayService=new WxPayService();
			RedisUtil.expired(ImConstants.WXPAY_ORDER_KEY.getBytes(), 60 * 30);
			RedisUtil.hset(ImConstants.WXPAY_ORDER_KEY, outtradeno, JSON.toJSONString(order));
			wxPayService.setOut_trade_no(outtradeno);
			wxPayService.setTotal_fee(amount.multiply(new BigDecimal(100)).intValue()+"");
			wxPayService.setUserId(userId);
			Map<String, String> result=wxPayService.prePay(body+" "+subject, wxPayService.getIpAddr(request),String.valueOf(userId));
			orderString=wxPayService.getPreString(result);
		} catch (Exception e) {
			RedisUtil.hset("wxpayError",outtradeno, e.getMessage());
		    e.printStackTrace();
		}
		data.put("orderString", orderString);
		data.put("outTradeNo", outtradeno);
		return data;
	}
	
	
	
	
	public static void main(String args[]) {
		BigDecimal a = new BigDecimal("4");
		BigDecimal b = new BigDecimal("3");
		System.out.println(a.compareTo(b));
	}

	public HashMap<String, Object> alipayOrder(String sessid, BigDecimal amount, String body, String subject) {
		HashMap<String, Object> data= new HashMap<>();
		try {
			Properties pro = new Properties();
			InputStream in = this.getClass().getResourceAsStream("/config/alipay.properties");
			pro.load(in);
			String date=new SimpleDateFormat("yyyyMMdd").format(new Date());
			String time=new SimpleDateFormat("HHmmss").format(new Date());
			String outtradeno = date+"00001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
			while(RedisUtil.hget(ImConstants.AIPAY_ORDER_KEY, outtradeno) != null){
				outtradeno = date+"00001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
			}
			ImUserOrders order=new ImUserOrders();
			order.setAmount(amount);
			order.setUserId(new Long(0));
			order.setContent(body+" "+subject);
			order.setOutTradeNo(outtradeno);
			order.setNotifyString("");
			order.setPlat("alipay");
			order.setSessionid(sessid);
			order.setType(new Long(1));
			save(order);
//			System.out.println(outtradeno);
			//实例化客户端
			AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", pro.getProperty("APP_ID"),pro.getProperty("APP_PRIVATE_KEY"), "json", pro.getProperty("CHARSET"), pro.getProperty("ALIPAY_PUBLIC_KEY"), "RSA2");
			//实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
			AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
			//SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
			AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
			model.setBody(body);
			model.setSubject(subject);
			model.setOutTradeNo(outtradeno);
			model.setTimeoutExpress("30m");
			model.setTotalAmount(amount+"");
			model.setProductCode("QUICK_MSECURITY_PAY");
			request.setBizModel(model);
			request.setNotifyUrl("http://samim.huiwork.com:8080/wmsMobile/wallet/alipayNotify");		
			order.setOutString(JSON.toJSONString(model));
			String orderString="";
			try {
				RedisUtil.expired(ImConstants.AIPAY_ORDER_KEY.getBytes(), 60 * 30);
				RedisUtil.hset(ImConstants.AIPAY_ORDER_KEY, outtradeno, JSON.toJSONString(model));
				RedisUtil.hset(("RequestSessions|"+sessid).getBytes(),("outTradeNo"+outtradeno).getBytes(),JSON.toJSONString(order).getBytes());
			        //这里和普通的接口调用不同，使用的是sdkExecute
			        AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
			        orderString=response.getBody();
			    } catch (AlipayApiException e) {
			        e.printStackTrace();
			}
			data.put("orderString", orderString);
			data.put("outTradeNo", outtradeno);
			return data;
		} catch (IOException e) {
			// TODO: handle exception
			RedisUtil.lpush("logs", "alipayNotify"+new SimpleDateFormat("yyyyMMdd-HHmmss").format(new Date())+"-"+JSON.toJSONString(e));
		}
		return data;
	}

	public HashMap<String, Object> wxPayOrder(String sessid, BigDecimal amount, String body, String subject,
			HttpServletRequest request) {
		// TODO Auto-generated method stub
		HashMap<String, Object> data= new HashMap<>();
		String date=new SimpleDateFormat("yyyyMMdd").format(new Date());
		String time=new SimpleDateFormat("HHmmss").format(new Date());
		String outtradeno = date+"001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
		while(RedisUtil.hget(ImConstants.WXPAY_ORDER_KEY, outtradeno) != null){
			outtradeno = date+"001000"+ToolsService.getRandom(2)+"00"+time+ToolsService.getRandom(2);
		}
		ImUserOrders order=new ImUserOrders();
		order.setAmount(amount);
		order.setUserId(new Long(0));
		order.setContent(body+" "+subject);
		order.setOutTradeNo(outtradeno);
		order.setNotifyString("");
		order.setPlat("wxpay");
		order.setType(new Long(1));
		order.setSessionid(sessid);
		save(order);
		String orderString="";
		try {
			WxPayService wxPayService=new WxPayService();
			RedisUtil.expired(ImConstants.WXPAY_ORDER_KEY.getBytes(), 60 * 30);
			RedisUtil.hset(ImConstants.WXPAY_ORDER_KEY, outtradeno, JSON.toJSONString(order));
			wxPayService.setOut_trade_no(outtradeno);
			wxPayService.setTotal_fee(amount.multiply(new BigDecimal(100)).intValue()+"");
			wxPayService.setUserId(new Long(0));
			Map<String, String> result=wxPayService.prePay(body+" "+subject, wxPayService.getIpAddr(request),sessid);
			orderString=wxPayService.getPreString(result);
		} catch (Exception e) {
			RedisUtil.hset("wxpayError",outtradeno, e.getMessage());
		    e.printStackTrace();
		}
		data.put("orderString", orderString);
		data.put("outTradeNo", outtradeno);
		return data;
	}


	public void initWallet(Long userId){
		ImWallet wallet = (ImWallet) this.queryForObject("from ImWallet where userId=?", userId);
		if (wallet == null) {
			ImWallet userWallet=new ImWallet();
			userWallet.setUserId(userId);
			userWallet.setMoney(new BigDecimal(1000));
			userWallet.setStatus(1);
			this.save(userWallet);
		}
	}
}
