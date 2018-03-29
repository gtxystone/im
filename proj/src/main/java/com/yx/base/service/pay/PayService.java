package com.yx.base.service.pay;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.yx.base.extendmodel.ImUserOrders;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImRedpacket;
import com.yx.base.model.ImUserPay;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parames.WalletConstants;
import com.yx.base.parameter.Constants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.service.login.ReadyService;

@SuppressWarnings({"rawtypes","unchecked"})
@Service
public class PayService  extends EntityServiceImpl{

	
	public static boolean isLock = false;
	
	@Autowired
	private ReadyService readyService;
	
	/**
	 * 更新或者设置支持密码
	 * @param userId
	 * @param pwd
	 * @throws IOException 
	 */
	public int setPayPwd(long userId,String pwd) throws IOException{
		ImUserPay userPay=(ImUserPay)this.queryForObject("from ImUserPay where userId=?", userId);
		if(userPay!=null&&pwd.equals(userPay.getOldPwd())){
			return 2;
		}
		if(userPay!=null&&userPay.getUserId()>0){			
			userPay.setOldPwd(userPay.getPayPwd());
			userPay.setPayPwd((pwd));
			userPay.setUpdateTime(System.currentTimeMillis());
			this.update(userPay);
		}else{
			userPay=new ImUserPay();
			userPay.setUserId(userId);
			userPay.setCreateTime(System.currentTimeMillis());
			userPay.setUpdateTime(System.currentTimeMillis());
			userPay.setPayPwd((pwd));
			this.save(userPay);
		}
		readyService.cacheImUserPay(userId);
		return Constants.SUCCESS_CODE;
	}
	
	
	public boolean validatePayPwd(long userId,String pwd){
		ImUserPay userPay=(ImUserPay)this.queryForObject("from ImUserPay where userId=?", userId);
		if(userPay.getPayPwd().equals(pwd)){
			return true;
		}
		return false;
	}
	
	public boolean hasPayPwd(long userId){
		ImUserPay userPay=(ImUserPay)this.queryForObject("from ImUserPay where userId=?", userId);
		if(userPay!=null&&userPay.getUserId()>0){
			return true;
		}
		return false;
	} 
	
	public List getVipNumber(String type) throws IOException{
		Set<byte[]> nums=RedisUtil.hkeys(ImConstants.IM_NUMBER_KEY.getBytes());
		String numbers="";
		for (byte[] bs : nums) {
			if (bs!=null) {
				numbers+=new String(bs)+",";
			}
		}
		String sql="";
		if (StringUtils.isBlank(numbers)) {
			sql="select id as nid,number as num,price from im_sam_number where used=0 and userId is Null and locate(?,rule)>0  order by RAND() limit 10";
		}else{
			sql="select id as nid,number as num,price from im_sam_number where used=0 and number not in ("+numbers.substring(0, numbers.length()-1)+") and userId is Null and locate(?,rule)>0  order by RAND() limit 10";			
		}
		System.out.println(sql);
		return this.queryForObjListBySql(sql,("pairs-"+type).toLowerCase());
	}
	
	public List getNumberType() throws IOException{
		return this.queryForObjListBySql("select id as tid,type as typeName from im_sam_number_type where isdelete =?", "0");
	}
	
	public boolean checkNumber(String number){
		Object object=this.queryForValueBySql("select count(*) from im_user where imNumber=?", number);
		return (object!=null&&Integer.parseInt(object.toString())>0)?true:false;
	}
	
	/**
	 * 靓号回收线程
	 * @throws ParseException 
	 */
	public void numberReturnBack(){
		if (!isLock) {
			isLock=true;
			List<ImUserOrders> imUserOrders=(List<ImUserOrders>)this.find("from ImUserOrders where status IN(0,2) and type=1");
			if (imUserOrders != null) {
				for (ImUserOrders order : imUserOrders) {
					long userId=order.getUserId();
					String createAt = order.getCreateTime();
					String sessid=order.getSessionid();
					long id=order.getId();

					// 测试时为30秒
					try {
						if (System.currentTimeMillis() - new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(createAt).getTime() > WalletConstants.IM_NUMBER_TIME_OUT) {					
							if (!StringUtils.isBlank(sessid)) {
							byte[] bytes=RedisUtil.hget(("RequestSessions|"+sessid).getBytes(), "number".getBytes());
							String number=bytes!=null?new String(bytes):null;
							if (number!=null) {
								// 释放号码
								RedisUtil.hdel(ImConstants.IM_NUMBER_KEY, number);
							}
							RedisUtil.delete(("RequestSessions|"+sessid).getBytes());
							order.setStatus(3);
							save(order);
							}
						}
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						continue;
					}
				}
			}
			Map<byte[], byte[]> numbers=RedisUtil.hgetAll(ImConstants.IM_NUMBER_KEY.getBytes());
			for (Entry<byte[], byte[]> num:numbers.entrySet()) {
				if (num.getKey()!=null&&num.getValue()!=null) {
					if (new Long(new String(num.getValue()))+300000<System.currentTimeMillis()) {
						RedisUtil.hdel(ImConstants.IM_NUMBER_KEY, new String(num.getKey()));
					}
				}
				
			}
			isLock=false;
		}
	}
}
