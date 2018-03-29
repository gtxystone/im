package com.yx.base.service.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.yx.base.extendmodel.ImSamNumber;
import com.yx.base.extendmodel.ImUserOrders;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.wallet.WalletService;

@SuppressWarnings("rawtypes")
@Service
public class OrderService  extends EntityServiceImpl{
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MsgStoreAndNotify chatService;

	@Autowired
	private WalletService walletService;
	
	public ImUserOrders getOrderBySn(String sn,String plat) {
		return (ImUserOrders) this.queryForObject("from ImUserOrders where outTradeNo=? and plat=?", sn,plat);
	}
	
	public boolean updateOrderStatus(String sn,int status,String plat){
		if (this.update("update ImUserOrders set status=? where outTradeNo=? and plat=?", status,sn,plat)>0) {
			return true;
		}
		return false;
	}
	
	@SuppressWarnings("unchecked")
	public boolean wxOrderNotify(ImUserOrders order,Map<String, String> map) throws IOException{
		if (order.getType()==1) {
			//  靓号注册或绑定
			ImSamNumber imSamNumber=(ImSamNumber) this.queryForObject("from ImSamNumber where number=?", new String(RedisUtil.hget(("RequestSessions|"+order.getSessionid()).getBytes(),"number".getBytes())));
			byte[] byteS=RedisUtil.hget(("RequestSessions|"+order.getSessionid()).getBytes(),"user".getBytes());
			Map<String, Object> model=JSONArray.parseObject(new String(byteS));
			ImUser user=new ImUser();
			if (model.get("id")!=null) {
				user=userService.getImUser(Long.parseLong(model.get("id").toString()));
			}else{
				user.setHeadUrl(model.get("headUrl").toString());
				user.setName(model.get("name").toString());
				user.setNickName(model.get("name").toString());
				user.setMobile(model.get("mobile").toString());
				user.setPwd(model.get("pwd").toString());
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
			return true;
		}else{
			ImUser member=userService.getImUser(order.getUserId());
			if (member==null) {
				RedisUtil.hset("wxpayError", order.getOutTradeNo(), "用户资料获取失败,requstData="+JSON.toJSONString(map));
			}
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
			this.update(order);
			this.updateOrderStatus(order.getOutTradeNo(), 1, "wxpay");
			return true;
		}
	}
}
