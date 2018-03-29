package com.yx.base.service.redpacket;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.yx.base.extendmodel.ImRedPacket;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImRedpacket;
import com.yx.base.model.ImRedpacketHistory;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parames.WalletConstants;
import com.yx.base.parameter.Constants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.group.GroupService;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;

import javassist.compiler.ast.StringL;

@SuppressWarnings("rawtypes")
@Service
public class RedPacketService extends EntityServiceImpl {

	@Autowired
	private MessageFactory msgFactory;

	@Autowired
	private GroupService groupService;

	@Autowired
	private MsgStoreAndNotify chatService;

	@Autowired
	private WalletService walletService;
	
	@Autowired
	private UserService userService;

	/**
	 * 发红包流程
	 * 
	 * @param redPacketCount
	 * @param userId
	 * @param redPacketAmount
	 * @param destType
	 * @param destId
	 * @param redPacketType
	 * @param redPacketContent
	 * @throws IOException 
	 */
	@Transactional
	public long createRedPacket(int redPacketCount, long userId, BigDecimal redPacketAmount, int destType, long destId,
			int redPacketType, String redPacketContent) throws IOException {
		
		//判断余额是否充足
		if(redPacketType== Constants.RED_PACKET_TYPE_RANDOM){
			//随机金额
			if(!walletService.validateBalance(userId, redPacketAmount)){
				return 0l;
			}
		}
		if(redPacketType==Constants.RED_PACKET_TYPE_AVG){
			//等额金额
			BigDecimal tempAmount=redPacketAmount.multiply(new BigDecimal(redPacketCount));
			if(!walletService.validateBalance(userId, tempAmount)){
				return 0l;
			}
		}		
		
		
		
		//保存到发红包记录
		ImRedpacket packet = new ImRedpacket();
		packet.setDestId(destId);
		packet.setUserId(userId);
		packet.setDestType(destType);
		packet.setRedPacketAmount(redPacketAmount);
		packet.setRedPacketCount(redPacketCount);
		packet.setRedPacketType(redPacketType);
		packet.setRedPacketContent(redPacketContent);
		packet.setStatus(1);	
		packet.setSendTime(System.currentTimeMillis());
		this.save(packet);
		
		ImMessage msg = msgFactory.redPacketNotice(packet.getId(), userId, destId, destType, redPacketContent);

		if (destType == IMConstants.MSG_FROM_GROUP && redPacketType == Constants.RED_PACKET_TYPE_RANDOM) {
			// 如果是群的随机红包
			String key = "redpacket_" + packet.getId();
			RedEnvelop red = new RedEnvelop(redPacketCount, Float.parseFloat(String.valueOf(redPacketAmount)));
			BigDecimal b = new BigDecimal(0);
			for (int i = 0; i < red.getCount(); i++) {
				BigDecimal m = red.nextRed();
				b = b.add(m);
				RedisUtil.lpush(key, String.valueOf(m.floatValue()));
				System.out.println("第" + (i + 1) + "个红包：" + m.floatValue());
			}	
			
			//保存到交易记录
			ImWalletHistory walletHis = new ImWalletHistory();
			walletHis.setAmount(packet.getRedPacketAmount());
			walletHis.setDestId(packet.getDestId());
			walletHis.setDestType(packet.getDestType());
			walletHis.setMoneyDirect(-1);
			walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
			walletHis.setOccurTime(System.currentTimeMillis());
			walletHis.setUserId(userId);
			this.save(walletHis);
			
			
			//更新wallet
			walletService.updateWallet(userId, redPacketAmount, -1);
		}

		else if (destType == IMConstants.MSG_FROM_GROUP && redPacketType == Constants.RED_PACKET_TYPE_AVG) {
			// 如果是群的等额红包
			String key = "redpacket_" + packet.getId();
			for (int i = 0; i < redPacketCount; i++) {
				RedisUtil.lpush(key, String.valueOf(redPacketAmount));
			}	
			
			//保存到交易记录
			ImWalletHistory walletHis = new ImWalletHistory();
			walletHis.setAmount(packet.getRedPacketAmount().multiply(new BigDecimal(packet.getRedPacketCount())));
			walletHis.setDestId(packet.getDestId());
			walletHis.setDestType(packet.getDestType());
			walletHis.setMoneyDirect(-1);
			walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
			walletHis.setOccurTime(System.currentTimeMillis());
			walletHis.setUserId(userId);
			this.save(walletHis);
			
			
			//更新wallet
			walletService.updateWallet(userId, redPacketAmount.multiply(new BigDecimal(redPacketCount)), -1);
		}

		if (destType == IMConstants.MSG_FROM_GROUP) {
			// 通知群用户有红包
			List<Map<String, Object>> memList = groupService.getAllMemberFromCache(destId);
			for (Map<String, Object> map : memList) {
				long memUserId = Long.parseLong(map.get("userId").toString());
				chatService.storeMsgAndNotifyImServer(msg, memUserId);
			}
		}

		if (destType == IMConstants.MSG_FROM_P2P) {
			
			//更新wallet
			walletService.updateWallet(userId, redPacketAmount, -1);
			
			//保存到交易记录
			ImWalletHistory walletHis = new ImWalletHistory();
			walletHis.setAmount(packet.getRedPacketAmount());
			walletHis.setDestId(packet.getDestId());
			walletHis.setDestType(packet.getDestType());
			walletHis.setMoneyDirect(-1);
			walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
			walletHis.setOccurTime(System.currentTimeMillis());
			walletHis.setUserId(userId);
			this.save(walletHis);
			
			// 如果是个人之间的红包,通知好友有红包
			chatService.storeMsgAndNotifyImServer(msg, destId);
		}

		return packet.getId();
	}

	public static void main(String args[]) {
		BigDecimal bd = new BigDecimal("23424.33");
		System.out.println(bd.toString());

		java.text.DecimalFormat df=new java.text.DecimalFormat("#");
		System.out.println(df.format(Math.rint(22.59)));
		
		System.out.println(System.currentTimeMillis());

	}

	/**
	 * 打开红包
	 * 
	 * @param redPacketId
	 * @param userId
	 * @throws IOException 
	 */
	@Transactional
	public String updateRedPacket(long redPacketId, long userId) throws IOException {
				
		ImRedpacket redPacket = (ImRedpacket) this.queryForObject("from ImRedpacket where id=?", redPacketId);
		ImUser fromUser=userService.getImUser(redPacket.getUserId());
		if (redPacket != null) {
			// 个人红包
			if (redPacket.getDestType() == IMConstants.MSG_FROM_P2P) {
				if(redPacket.getDestId()!=userId){
					return null;
				}
				
				//保存到抢红包历史；
				ImRedpacketHistory history = new ImRedpacketHistory();
				history.setAmount(redPacket.getRedPacketAmount());
				history.setCreateTime(System.currentTimeMillis());
				history.setRedPacketId(redPacketId);
				history.setUserId(userId);
				this.save(history);
				this.updateBySql("update im_redpacket set status=2,finishTime=? where id=?", System.currentTimeMillis(),redPacketId);
				
				//保存到交易记录
				ImWalletHistory walletHis = new ImWalletHistory();
				walletHis.setAmount(redPacket.getRedPacketAmount());
				walletHis.setDestId(redPacket.getDestId());
				walletHis.setDestType(redPacket.getDestType());
				walletHis.setMoneyDirect(1);
				walletHis.setMoneyType(MoneyConstants.BILLING_RECEIVE_RED_PACKET);
				walletHis.setOccurTime(System.currentTimeMillis());
				walletHis.setUserId(userId);
				walletHis.setContent(fromUser.getName());
				this.save(walletHis);
				
				//更新余额+
				int rows=walletService.updateWallet(userId, redPacket.getRedPacketAmount(), 1);
				if(rows==0){
					new RuntimeException();
				}
				
				//通知发红包人
				ImMessage msg=msgFactory.receiveRedPacketNotice(redPacket.getId(), userId, redPacket.getUserId(), redPacket.getDestType(), redPacket.getRedPacketContent());
				chatService.storeMsgAndNotifyImServer(msg, redPacket.getUserId());
				
				return redPacket.getRedPacketAmount().toString();
			}

			// 群红包
			else if (redPacket.getDestType() == IMConstants.MSG_FROM_GROUP) {
				List list=this.queryForObjListBySql("select userId from im_group_member where userId in(?) and groupId=?",userId, redPacket.getDestId());
				if(list==null||list.size()==0){
					return null;
				}
				String key = "redpacket_" + redPacketId;
				
				String amount = RedisUtil.rpop(key);
				long len=RedisUtil.llen(key);
				if (amount != null) {
					
					//保存到抢红包历史 
					ImRedpacketHistory history = new ImRedpacketHistory();
					history.setAmount(new BigDecimal(amount));
					history.setCreateTime(System.currentTimeMillis());
					history.setRedPacketId(redPacketId);
					history.setUserId(userId);
					this.save(history);					
					
					
					//保存到交易记录
					ImWalletHistory walletHis = new ImWalletHistory();
					walletHis.setAmount(new BigDecimal(amount));
					walletHis.setDestId(redPacket.getDestId());	
					walletHis.setDestType(redPacket.getDestType());
					walletHis.setMoneyDirect(1);
					walletHis.setMoneyType(MoneyConstants.BILLING_RECEIVE_RED_PACKET);
					walletHis.setOccurTime(System.currentTimeMillis());
					walletHis.setUserId(userId);
					walletHis.setContent(fromUser.getName());
					this.save(walletHis);
					
					//更新余额+
					int rows=walletService.updateWallet(userId, new BigDecimal(amount), 1);
					if(rows==0){
						new RuntimeException();
					}
					
					//通知发红包人
					ImMessage msg=msgFactory.receiveRedPacketNotice(redPacket.getId(), userId, redPacket.getDestId(), redPacket.getDestType(), redPacket.getRedPacketContent());
					chatService.storeMsgAndNotifyImServer(msg, redPacket.getUserId());
					
					if (len == 0) {
						this.updateBySql("update im_redpacket set status=2,finishTime=? where id=?", System.currentTimeMillis(),redPacketId);
						//通知发红包人抢光
						ImMessage finishedMsg=msgFactory.receiveRedFinishedNotice(redPacket.getId(), userId, redPacket.getDestId(), redPacket.getDestType(), System.currentTimeMillis()-redPacket.getSendTime()+"");
						chatService.storeMsgAndNotifyImServer(finishedMsg, redPacket.getUserId());
						// 通知群用户口令红包发送抢光通知
						if (redPacket.getRedPacketType()==ImConstants.RED_PACKET_TYPE_COMMAND) {
							//通知发红包人
							ImMessage msgCommand=msgFactory.commandRedPacketNotice(redPacket.getId(), userId, redPacket.getDestId(), redPacket.getDestType(), redPacket.getRedPacketContent());
							List<Map<String, Object>> memList = groupService.getAllMemberFromCache(redPacket.getDestId());
							for (Map<String, Object> map : memList) {
								long memUserId = Long.parseLong(map.get("userId").toString());
								chatService.storeMsgAndNotifyImServer(msgCommand, memUserId);
							}
						}
					}
					return amount;
				}
			}
			
			
		}
		return null;
	}

	/**
	 * 查看抢红包的
	 * 
	 * @param redPacketId
	 * @return
	 */
	public HashMap<String, Object> getRedPacketHistory(long redPacketId, long userId) {
		Object redPacket = this.queryForObjectBySql("select a.*,b.name,b.headUrl from im_redpacket a left join im_user b on(a.userId=b.id) where a.id=?", redPacketId);
		HashMap<String, Object> map = new HashMap<String, Object>();

		if(redPacket!=null){
			HashMap<String,Object> redMap=(HashMap<String,Object>)redPacket;
			Object status=redMap.get("status");
			if(status!=null&&status.toString().equals("2")){
				long time=Long.parseLong(redMap.get("finishTime").toString())-Long.parseLong(redMap.get("sendTime").toString());
				java.text.DecimalFormat df=new java.text.DecimalFormat("#");
				map.put("time", df.format(Math.rint(time/1000)));
			}else{
				map.put("time", -1);
			}
		}else{
			map.put("time", -1);
		}
		map.put("redPacket", redPacket);

		List list = this.queryForObjListBySql(
				"select a.userId,a.amount,a.createTime,b.name,b.headUrl from im_redpacket_history a LEFT JOIN im_user b on(a.userId=b.id)  where a.redPacketId=?",
				redPacketId);
		map.put("redPacketHistory", list);

		return map;
	}
	
	
	public void checkAndReturnRed(){
		List<ImRedpacket> redList = (List<ImRedpacket>) this.find("from ImRedpacket where status=1");
		if (redList != null) {
			for (ImRedpacket redpacket : redList) {
				long userId = redpacket.getUserId();
				BigDecimal amount = redpacket.getRedPacketAmount();
				long sendTime = redpacket.getSendTime();
				long id = redpacket.getId();

				// 测试时为1分钟
				if (System.currentTimeMillis() - sendTime > WalletConstants.REDPACKET_TIME_OUT) {					

					//打开剩余的红包
					String key = "redpacket_" + redpacket.getId();
					BigDecimal lastAmount=new BigDecimal("0.00");
					
					//群红包就去查redis剩余
					if(redpacket.getDestType()==IMConstants.MSG_FROM_GROUP){
						while(RedisUtil.llen(key)>0){
							lastAmount=lastAmount.add(new BigDecimal(RedisUtil.rpop(key)));
						}
					}
					
					//个人红包去查数据库剩余
					if(redpacket.getDestType()==IMConstants.MSG_FROM_P2P){
						lastAmount=redpacket.getRedPacketAmount();
					}
					
					
					// 更新转账状态
					if(lastAmount.compareTo(new BigDecimal("0.00"))>0){
						int row = this.updateBySql("update im_redpacket set status=3 where id=? and userId=?", id, userId);
						if (row == 0) {
							System.out.println("剩余金额为0，可能被领取完成，更新为2");
							this.updateBySql("update im_redpacket set status=2 where id=? and userId=?", id, userId);
							continue;
						}
					}else{
						continue;
					}
										
					// 保存到交易记录
					ImWalletHistory history = new ImWalletHistory();
					history.setAmount(lastAmount);
					history.setDestId(id);
					history.setMoneyDirect(1);
					history.setDestType(redpacket.getDestType());
					history.setMoneyType(MoneyConstants.BILLING_RED_FEEDBACK);
					history.setOccurTime(System.currentTimeMillis());
					history.setUserId(userId);					
					this.save(history);
					
					//修改余额
					int rows=walletService.updateWallet(userId, lastAmount, 1);
					if(rows==0){
						new RuntimeException();
						continue ;
					}
					// 通知红包发起人，钱已经退回
					ImMessage message = msgFactory.redPacketBackNotice(redpacket,lastAmount);
					chatService.storeMsgAndNotifyImServer(message, userId);
					
				}
			}
		}
	}

	public long createRedPacket(int redPacketCount, long userId, BigDecimal redPacketAmount, int destType, long destId,
			int redPacketType, String redPacketContent, String command,String limit) throws IOException {
		//判断余额是否充足
				if(redPacketType== Constants.RED_PACKET_TYPE_RANDOM||redPacketType==ImConstants.RED_PACKET_TYPE_COMMAND){
					//随机金额
					if(!walletService.validateBalance(userId, redPacketAmount)){
						return 0l;
					}
					if (redPacketType==ImConstants.RED_PACKET_TYPE_COMMAND) {
						redPacketContent=command;
					}
				}
				if(redPacketType==Constants.RED_PACKET_TYPE_AVG){
					//等额金额
					BigDecimal tempAmount=redPacketAmount.multiply(new BigDecimal(redPacketCount));
					if(!walletService.validateBalance(userId, tempAmount)){
						return 0l;
					}
				}		
				
				
				
				//保存到发红包记录
				ImRedPacket packet = new ImRedPacket();
				packet.setDestId(destId);
				packet.setUserId(userId);
				packet.setDestType(destType);
				packet.setRedPacketAmount(redPacketAmount);
				packet.setRedPacketCount(redPacketCount);
				packet.setRedPacketType(redPacketType);
				packet.setRedPacketContent(redPacketContent);
				packet.setStatus(1);	
				packet.setSendTime(System.currentTimeMillis());
				packet.setCommand(command);
				packet.setLimit(limit);
				this.save(packet);
				
				ImMessage msg = msgFactory.redPacketNotice(packet.getId(), userId, destId, destType, redPacketContent,command,redPacketType);

				if (destType == IMConstants.MSG_FROM_GROUP && (redPacketType == Constants.RED_PACKET_TYPE_RANDOM||redPacketType==ImConstants.RED_PACKET_TYPE_COMMAND)) {
					// 如果是群的随机红包
					String key = "redpacket_" + packet.getId();
					RedEnvelop red = new RedEnvelop(redPacketCount, Float.parseFloat(String.valueOf(redPacketAmount)));
					BigDecimal b = new BigDecimal(0);
					for (int i = 0; i < red.getCount(); i++) {
						BigDecimal m = red.nextRed();
						b = b.add(m);
						RedisUtil.lpush(key, String.valueOf(m.floatValue()));
						System.out.println("第" + (i + 1) + "个红包：" + m.floatValue());
					}	
					
					//保存到交易记录
					ImWalletHistory walletHis = new ImWalletHistory();
					walletHis.setAmount(packet.getRedPacketAmount());
					walletHis.setDestId(packet.getDestId());
					walletHis.setDestType(packet.getDestType());
					walletHis.setMoneyDirect(-1);
					walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
					walletHis.setOccurTime(System.currentTimeMillis());
					walletHis.setUserId(userId);
					this.save(walletHis);
					
					
					//更新wallet
					walletService.updateWallet(userId, redPacketAmount, -1);
				}

				else if (destType == IMConstants.MSG_FROM_GROUP && redPacketType == Constants.RED_PACKET_TYPE_AVG) {
					// 如果是群的等额红包
					String key = "redpacket_" + packet.getId();
					for (int i = 0; i < redPacketCount; i++) {
						RedisUtil.lpush(key, String.valueOf(redPacketAmount));
					}	
					
					//保存到交易记录
					ImWalletHistory walletHis = new ImWalletHistory();
					walletHis.setAmount(packet.getRedPacketAmount().multiply(new BigDecimal(packet.getRedPacketCount())));
					walletHis.setDestId(packet.getDestId());
					walletHis.setDestType(packet.getDestType());
					walletHis.setMoneyDirect(-1);
					walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
					walletHis.setOccurTime(System.currentTimeMillis());
					walletHis.setUserId(userId);
					this.save(walletHis);
					
					
					//更新wallet
					walletService.updateWallet(userId, redPacketAmount.multiply(new BigDecimal(redPacketCount)), -1);
				}

				if (destType == IMConstants.MSG_FROM_GROUP) {
					// 通知群用户有红包
					List<Map<String, Object>> memList = groupService.getAllMemberFromCache(destId);
					for (Map<String, Object> map : memList) {
						long memUserId = Long.parseLong(map.get("userId").toString());
						chatService.storeMsgAndNotifyImServer(msg, memUserId);
					}
				}

				if (destType == IMConstants.MSG_FROM_P2P) {
					
					//更新wallet
					walletService.updateWallet(userId, redPacketAmount, -1);
					
					//保存到交易记录
					ImWalletHistory walletHis = new ImWalletHistory();
					walletHis.setAmount(packet.getRedPacketAmount());
					walletHis.setDestId(packet.getDestId());
					walletHis.setDestType(packet.getDestType());
					walletHis.setMoneyDirect(-1);
					walletHis.setMoneyType(MoneyConstants.BILLING_SEND_RED_PACKET);
					walletHis.setOccurTime(System.currentTimeMillis());
					walletHis.setUserId(userId);
					this.save(walletHis);
					
					// 如果是个人之间的红包,通知好友有红包
					chatService.storeMsgAndNotifyImServer(msg, destId);
				}

				return packet.getId();
	}
	
	@Transactional
	public int checkOpenLimit(long redPacketId, long userId) throws IOException {
		ImRedPacket packet=(ImRedPacket)this.queryForObject("from ImRedPacket where id=?", redPacketId);
		if (packet==null) {
			return 1;
		}
		String limit=packet.getLimit();
		if (StringUtils.isBlank(limit)) {
			return 0;
		}
		JSONArray ids=JSON.parseArray(limit);
		for (Object id : ids) {
			if (Long.parseLong(id.toString())==userId) {
				return 0;
			}
		}
		return -1;
	}

}
