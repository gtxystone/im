package com.yx.base.service.wallet;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.druid.support.http.util.IPAddress;
import com.alibaba.fastjson.JSON;
import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConfigImpl;
import com.github.wxpay.sdk.WXPayConstants.SignType;
import com.github.wxpay.sdk.WXPayUtil;

public class WxPayService {
	
	private WXPay wxPay;
	private WXPayConfigImpl config;
    private String out_trade_no;
    private String total_fee;
    private Long userId;
	
	public WxPayService() throws Exception{
		config = WXPayConfigImpl.getInstance();
        wxPay = new WXPay(config);
	}
	
	public String getOut_trade_no() {
		return out_trade_no;
	}

	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}

	public String getTotal_fee() {
		return total_fee;
	}

	public void setTotal_fee(String total_fee) {
		this.total_fee = total_fee;
	}

	public Map<String, String> prePay(String body,String ipAddress,String attach){
		Map<String, String> reqData=new HashMap<>();
		reqData.put("body", body);
		reqData.put("out_trade_no", this.getOut_trade_no());
		reqData.put("device_info", "");
		reqData.put("fee_type", "CNY");
		reqData.put("attach", attach);
		reqData.put("total_fee", this.getTotal_fee());
		reqData.put("spbill_create_ip", ipAddress);
		reqData.put("notify_url", "http://samim.huiwork.com:8080/wmsMobile/wallet/wxpayNotify");
		reqData.put("trade_type", "APP");
		try {
			return wxPay.unifiedOrder(reqData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String getPreString(Map<String, String> data) {
		try {
			Map<String, String> signData=new HashMap<>();
			signData.put("appid", config.getAppID());
			signData.put("partnerid", config.getMchID());
			signData.put("prepayid", data.get("prepay_id"));
			signData.put("package","Sign=WXPay");
			signData.put("noncestr",getNonceStr());
			signData.put("timestamp",WXPayUtil.getCurrentTimestamp()+"");
			signData.put("sign", WXPayUtil.generateSignature(signData, config.getKey(),SignType.HMACSHA256));
			return JSON.toJSONString(signData);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public String signData(Map<String, String> signData){
		try {
			return WXPayUtil.generateSignature(signData, config.getKey(),SignType.HMACSHA256);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public String setXml(String return_code,String return_msg){  
	    return "<xml><return_code><![CDATA["+return_code+"]]></return_code><return_msg><![CDATA["+return_msg+"]]></return_msg></xml>";
	}
	public String getNonceStr(){
		return WXPayUtil.generateNonceStr();
	}
	
	public boolean checkSign(Map<String, String> data){
		try {
			return WXPayUtil.isSignatureValid(data, config.getKey(),SignType.HMACSHA256);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	
	public String getIpAddr(HttpServletRequest request) {  
	    String ip = request.getHeader("x-forwarded-for");  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	    }  
	    return ip;  
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	} 
}
