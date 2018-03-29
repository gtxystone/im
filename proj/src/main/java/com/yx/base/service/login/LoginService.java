package com.yx.base.service.login;

import java.util.Arrays;

import javax.mail.Flags.Flag;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.service.EntityServiceImpl;
import com.github.jarod.qqwry.IPZone;
import com.github.jarod.qqwry.QQWry;
import com.yx.base.service.chat.ChatConfig;

@SuppressWarnings("rawtypes")
@Service
public class LoginService extends EntityServiceImpl {
	
	@Autowired
	private ChatConfig config;
	
	public static String getClientIP(HttpServletRequest request) {  
	    String fromSource = "X-Real-IP";  
	    String ip = request.getHeader("X-Real-IP");  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("X-Forwarded-For");  
	        fromSource = "X-Forwarded-For";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	        fromSource = "Proxy-Client-IP";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	        fromSource = "WL-Proxy-Client-IP";  
	    }  
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	        fromSource = "request.getRemoteAddr";  
	    }  
	    System.out.println("App Client IP: "+ip+", fromSource: "+fromSource);  
	    return ip;  
	}  
	
	public boolean userLimit(long userId){
		String users[]={
				"17228",
				"17229",
				"17230",
				"17231",
				"17232",
				"17233",
				"17234",
				"17235",
				"17236",
				"17237",
				"17238",
				"17239",
				"17240",
				"17241",
				"17242",
				"17243",
				"17244",
				"17245",
				"17246",
				"17247",
				"17248",
				"17249",
				"17250",
				"17251",
				"17252",
				"17253",
				"17254",
				"17255",
				"17256",
				"17257",
				"17258",
				"17259",
				"17260",
				"17261",
				"17262",
				"17263",
				"17264",
				"17265",
				"17266",
				"17267",
				"17268",
				"17269",
				"17270",
				"17271",
				"17272",
				"17273",
				"17274",
				"17275",
				"17276",
				"17277",
				"17278",
				"17279",
				"17280",
				"17281",
				"17282",
				"17283",
				"17284",
				"17285",
				"17286",
				"17287",
				"17288",
				"17289",
				"17290",
				"17291",
				"17292",
				"17293",
				"17294",
				"17295",
				"17296",
				"17297",
				"17298",
				"17299",
				"17300",
				"17301",
				"17302",
				"17303",
				"17304",
				"17305",
				"17241",
				"17242",
				"17243",
				"17244",
				"17245",
				"17246",
				"17247",
				"17248",
				"17249",
				"17250",
				"17251",
				"17252",
				"17253",
				"17254",
				"17255",
				"17256",
				"17257",
				"17258",
				"17259",
				"17260",
				"17261",
				"17262",
				"17263",
				"17264",
				"17265",
				"17266",
				"17267",
				"17268",
				"17269",
				"17270",
				"17271",
				"17272",
				"17273",
				"17274",
				"17275",
				"17276",
				"17277",
				"17278",
				"17279",
				"17280",
				"17281",
				"17282",
				"17283",
				"17284",
				"17285",
				"17286",
				"17287",
				"17288",
				"17289",
				"17290",
				"17291",
				"17292",
				"17293",
				"17294",
				"17295",
				"17296",
				"17297",
				"17298",
				"17299",
				"17300",
				"17301",
				"17302",
				"17303",
				"17304",
				"17305",
				"17306",
				"17307",
				"17308",
				"17309",
				"17310",
				"17311",
				"17312",
				"17313",
				"17314",
				"17315",
				"17316",
				"17317",
				"17318",
				"17319",
				"17320",
				"17321",
				"17322",
				"17323",
				"17324",
				"17325",
				"17326",
				"17327",
				"17328",
				"17329",
				"17330",
				"17331",
				"17332",
				"17333",
				"17334",
				"17335"};
		if (Arrays.asList(users).contains(String.valueOf(userId))) {
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @param request
	 * @return
	 */
	public String getImServiceUrl(HttpServletRequest request,int device) {
		try {
			return "47.75.177.61";
						
			/*
			String clientIp = getClientIP(request);
			QQWry qqwry = new QQWry();
			IPZone ipzone = qqwry.findIP(clientIp);
			String detailAddr = ipzone.getMainInfo() + "," + ipzone.getSubInfo();
			
						
			
			// 华南1
			if (detailAddr.indexOf("广东") != -1 || detailAddr.indexOf("江苏") != -1 || detailAddr.indexOf("广西") != -1
					|| detailAddr.indexOf("云南") != -1 || detailAddr.indexOf("安徽") != -1
					|| detailAddr.indexOf("海南") != -1 || detailAddr.indexOf("江西") != -1
					|| detailAddr.indexOf("澳门") != -1 || detailAddr.indexOf("贵州") != -1) {
				return "112.74.42.167";
			}
					
			
			
			// 华东1
			if ( detailAddr.indexOf("上海") != -1 || detailAddr.indexOf("") != -1
					|| detailAddr.indexOf("浙江") != -1 || detailAddr.indexOf("福建") != -1
					|| detailAddr.indexOf("重庆") != -1 || detailAddr.indexOf("湖北") != -1
					|| detailAddr.indexOf("四川") != -1 || detailAddr.indexOf("湖南") != -1) {
				return "116.62.13.57";
			}
			
			// 华北1
			if (detailAddr.indexOf("山东") != -1 ||detailAddr.indexOf("北京") != -1 || detailAddr.indexOf("河南") != -1 || detailAddr.indexOf("河北") != -1
					|| detailAddr.indexOf("陕西") != -1 || detailAddr.indexOf("天津") != -1
					|| detailAddr.indexOf("山西") != -1 || detailAddr.indexOf("辽宁") != -1
					|| detailAddr.indexOf("黑龙江") != -1 || detailAddr.indexOf("内蒙古") != -1
					|| detailAddr.indexOf("甘肃") != -1 || detailAddr.indexOf("青海") != -1
					|| detailAddr.indexOf("新疆") != -1 || detailAddr.indexOf("西藏") != -1
					|| detailAddr.indexOf("吉林") != -1 || detailAddr.indexOf("宁夏") != -1) {
				return "59.110.113.177";
			}
*/
			/*
			// 香港
			if (detailAddr.indexOf("香港") != -1) {
				return "47.91.158.95";
			}
			// 日本/台湾
			if (detailAddr.indexOf("日本") != -1 || detailAddr.indexOf("台湾") != -1) {
				return "47.91.16.244";
			}
			// 新加坡/韩国
			if (detailAddr.indexOf("新加坡") != -1 || detailAddr.indexOf("韩国") != -1) {
				return "47.88.242.54";
			}
			// 美国
			if (detailAddr.indexOf("美国") != -1) {
				return "47.88.55.103";
			}
			*/
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 默认华北1服务器,本来应该112.74.42.167，测试改：139.129.250.144
		return "112.74.42.167";
				
	}

	public static void main(String args[]) {
		try {
			QQWry qqwry = new QQWry();
			IPZone ipzone = qqwry.findIP("112.251.182.223");
			String detailAddr = ipzone.getMainInfo() + "," + ipzone.getSubInfo();
			System.out.println(detailAddr.indexOf("山东"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
