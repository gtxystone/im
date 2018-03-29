package com.yx.base.service.transfer;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.yx.base.extendmodel.ImTransForm;
import com.yx.base.extendmodel.ImTransformAA;
import com.yx.base.extendmodel.ImTransformAARecord;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImTransform;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWalletHistory;
import com.yx.base.parames.ImConstants;
import com.yx.base.parames.WalletConstants;
import com.yx.base.parameter.Constants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.MoneyConstants;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.group.GroupService;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.user.UserService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.YxUtil;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service
public class TransferService extends EntityServiceImpl {

	public static boolean isLock = false;
	
	public static boolean aLock = false;

	@Autowired
	private MessageFactory msgFactory;

	@Autowired
	private UserService userService;
	
	@Autowired
	private GroupService groupService;

	@Autowired
	private MsgStoreAndNotify chatService;

	@Autowired
	private WalletService walletService;

	/**
	 * 开始转账
	 * 
	 * @param userId
	 * @param destId
	 * @param amount
	 * @param msg
	 * @return
	 * @throws IOException
	 */
	public ImTransform createTransfer(long userId, long destId, BigDecimal amount, String msg) throws IOException {
		
		ImUser destUser = userService.getImUser(destId);
		ImTransform trans = new ImTransform();
		trans.setAmount(amount);
		trans.setDestId(destId);
		trans.setMsg(msg);
		trans.setSendTime(System.currentTimeMillis());
		trans.setStatus(1);
		trans.setUserId(userId);
		this.save(trans);

		// 保存到交易记录
		ImWalletHistory walletHis = new ImWalletHistory();
		walletHis.setAmount(amount);
		walletHis.setDestId(destId);
		walletHis.setDestType(IMConstants.MSG_FROM_P2P);
		walletHis.setMoneyDirect(-1);
		walletHis.setMoneyType(MoneyConstants.BILLING_SEND_TRANSFER);
		walletHis.setOccurTime(System.currentTimeMillis());
		walletHis.setUserId(userId);
		walletHis.setContent(destUser.getName());
		this.save(walletHis);

		// 更新wallet
		walletService.updateWallet(userId, amount, -1);

		// 通知好友有转账信息
		ImMessage imMsg = msgFactory.transferNotice(trans.getId(), userId, destId, msg, trans.getAmount());
		chatService.storeMsgAndNotifyImServer(imMsg, destId);

		return trans;
	}

	/**
	 * 二维码收款
	 * 
	 * @param transId
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	@Transactional
	public boolean aATransfer(long userId, long destId, BigDecimal amount) throws IOException {
		
		if (!isLock) {
			isLock = true;

			ImTransform trans = new ImTransform();
			trans.setAmount(amount);
			trans.setDestId(destId);
			trans.setMsg("付款");
			trans.setSendTime(System.currentTimeMillis());
			trans.setStatus(2);
			trans.setUserId(userId);
			this.save(trans);

			ImUser destUser = (ImUser) userService.getImUser(destId);

			// 付款人，保存到交易记录
			ImWalletHistory fromWalletHis = new ImWalletHistory();
			fromWalletHis.setAmount(amount);
			fromWalletHis.setDestId(destId);
			fromWalletHis.setDestType(IMConstants.MSG_FROM_P2P);
			fromWalletHis.setMoneyDirect(-1);
			fromWalletHis.setMoneyType(MoneyConstants.BILLING_SEND_TRANSFER);
			fromWalletHis.setOccurTime(System.currentTimeMillis());
			fromWalletHis.setUserId(userId);
			fromWalletHis.setContent(destUser.getName());
			this.save(fromWalletHis);

			// 付款人，更新wallet
			walletService.updateWallet(userId, amount, -1);

			
			ImUser fromUser = (ImUser) userService.getImUser(userId);
			// 收款人，保存到交易记录
			ImWalletHistory walletHis = new ImWalletHistory();
			walletHis.setAmount(trans.getAmount());
			walletHis.setDestId(trans.getDestId());
			walletHis.setDestType(IMConstants.MSG_FROM_P2P);
			walletHis.setMoneyDirect(1);
			walletHis.setMoneyType(MoneyConstants.BILLING_RECEIVE_TRANSFER);
			walletHis.setOccurTime(System.currentTimeMillis());
			walletHis.setUserId(destId);
			walletHis.setContent(fromUser.getName());
			this.save(walletHis);

			// 收款人，更新wallet
			walletService.updateWallet(destId, trans.getAmount(), 1);

			// 通知收款人，已到账
			ImMessage msg = msgFactory.receiveMoneyNotice(userId,destId,trans.getAmount());
			msg.setFromId(userId);
			msg.setDestId(destId);
			chatService.storeMsgAndNotifyImServer(msg, destId);
			isLock = false;
			return true;

		}
		return false;
	}

	/**
	 * 确认转账
	 * 
	 * @param transId
	 * @param userId
	 * @return
	 * @throws IOException
	 */
	@Transactional
	public boolean updateConfimTransfer(long transId, long userId) throws IOException {
		if (!isLock) {
			isLock = true;
			ImTransForm trans = (ImTransForm) queryForObject("from ImTransForm where id=?", transId);
			ImUser fromUser = (ImUser) userService.getImUser(trans.getUserId());
			if (trans != null && trans.getStatus() == Constants.TRANS_PENDING) {
				int rows = this.updateBySql("update im_transform set confirmTime=?,status=2 where id=? and destId=?",
						System.currentTimeMillis(), transId, userId);
				isLock = false;
				if (rows > 0) {

					// 保存到交易记录
					ImWalletHistory walletHis = new ImWalletHistory();
					walletHis.setAmount(trans.getAmount());
					walletHis.setDestId(trans.getDestId());
					walletHis.setDestType(IMConstants.MSG_FROM_P2P);
					walletHis.setMoneyDirect(1);
					walletHis.setMoneyType(MoneyConstants.BILLING_RECEIVE_TRANSFER);
					walletHis.setOccurTime(System.currentTimeMillis());
					walletHis.setUserId(userId);
					walletHis.setContent(fromUser.getName());
					this.save(walletHis);

					// 更新wallet
					walletService.updateWallet(userId, trans.getAmount(), 1);

					if (trans.getGroupId()==0) {
						ImTransform transsingle = (ImTransform) queryForObject("from ImTransform where id=?", transId);
						// 通知好友 ，已收钱
						ImMessage msg = msgFactory.transferRecNotice(transsingle);
						chatService.storeMsgAndNotifyImServer(msg, trans.getUserId());
					}else {
						// 通知好友 ，已收钱
						ImMessage msg = msgFactory.transferRecNotice(trans);
						chatService.storeMsgAndNotifyImServer(msg, trans.getUserId());
					}
					return true;
				}
			}

		}
		return false;
	}

	/**
	 * 查看转账信息
	 * 
	 * @param transId
	 * @param userId
	 * @return
	 */
	public ImTransform viewTransfer(long transId, long userId) {
		return (ImTransform) this.queryForObject("from ImTransform where id=?", transId);
	}

	/**
	 * 转账退回功能 1，更新转账信息状态为退回 2，添加交易记录到账单 3，通知发起转账人，钱已经退回 4, 修改余额
	 */
	@Transactional
	public void updateCheckAndReturnTrans() {
		if (!isLock) {
			isLock = true;
			List<ImTransform> transList = (List<ImTransform>) this.find("from ImTransform where status=1");
			if (transList != null) {
				for (ImTransform trans : transList) {
					long userId = trans.getUserId();
					BigDecimal amount = trans.getAmount();
					long sendTime = trans.getSendTime();
					long id = trans.getId();

					// 测试时为1分钟
					if (System.currentTimeMillis() - sendTime > MoneyConstants.MONEY_TIMEOUT) {
						// 更新转账状态
						int row = this.updateBySql("update im_transform set status=3 where id=? and userId=?", id,
								userId);
						if (row == 0) {
							new RuntimeException();
							continue;
						}

						// 保存到交易记录
						ImWalletHistory history = new ImWalletHistory();
						history.setAmount(amount);
						history.setDestId(id);
						history.setMoneyDirect(1);
						history.setDestType(IMConstants.MSG_FROM_P2P);
						history.setMoneyType(MoneyConstants.BILLING_TRANSFER_FEEDBACK);
						history.setOccurTime(System.currentTimeMillis());
						history.setUserId(userId);
						this.save(history);

						// 修改余额
						int rows = walletService.updateWallet(userId, amount, 1);
						if (rows == 0) {
							new RuntimeException();
							continue;
						}
						// 通知转账发起人，钱已经退回
						ImMessage message = msgFactory.transferBackNotice(trans);
						chatService.storeMsgAndNotifyImServer(message, userId);
					}
				}
				isLock = false;
			}
		}

	}
	
	public Map aaTrans(long userId, int destType, long destId, String msg, BigDecimal totalAmount, int counts,double amt){
		int row=0;
		ImTransformAA transformAA=new ImTransformAA();
		transformAA.setDestId(destId);
		transformAA.setDestType(destType);
		transformAA.setUserId(userId);
		transformAA.setTotalAmount(totalAmount);
		transformAA.setMsg(msg);
		transformAA.setStatus(0);
		transformAA.setCreateTime(System.currentTimeMillis());
		transformAA.setUpdateTime(System.currentTimeMillis());
		transformAA.setCounts(counts);
		this.save(transformAA);
		if (counts>0) {
			String key="TransAA_"+transformAA.getId();
			for(int i=0;i<counts-1;i++){
				RedisUtil.lpush(key, String.valueOf(amt));
				row++;
			}
		}
		if (row==counts-1) {
			Map contentData=new HashMap<>();
			contentData.put("totalAmt", totalAmount);
			contentData.put("msg", msg);
			contentData.put("counts", counts);
			contentData.put("amt", amt);
			contentData.put("transId", transformAA.getId());
			return contentData;
		}else{
			this.delete(transformAA);
			RedisUtil.delete(("TransAA_"+transformAA.getId()).getBytes());
			return null;
		}
		
	}
	
	public ResponseData aaTransPay(long userId,long destId,long transId,BigDecimal amount){
		ImTransformAA transformAA=(ImTransformAA) this.queryForObject("from ImTransformAA where id=?", transId);
		if (transformAA.getStatus()==1) {
			return YxUtil.createFail("AA收款已经结束");
		}
		if (transformAA.getStatus()==2) {
			return YxUtil.createFail("AA收款已过期");
		}
		ImTransformAARecord rec=(ImTransformAARecord) this.queryForObject("from ImTransformAARecord where userId=? and destId=?", userId,transId);
		if (rec!=null) {
			return YxUtil.createFail("您已经支付过该笔转账");
		}
		byte[] redis = RedisUtil.lpop(("TransAA_"+transformAA.getId()).getBytes());
		if (redis!=null) {
			// 开始付款转账
			
			boolean result;
			try {
				result = this.aaTransRun(userId, destId, amount);
				if (result) {
					ImTransformAARecord record=new ImTransformAARecord();
					record.setAmount(amount);
					record.setCreateTime(System.currentTimeMillis());
					record.setDestId(transId);
					record.setUserId(userId);
					this.save(record);
					if (RedisUtil.llen("TransAA_"+transformAA.getId())==0) {
						transformAA.setStatus(1);
						transformAA.setUpdateTime(System.currentTimeMillis());
						this.save(transformAA);
					}
					return YxUtil.createSimpleSuccess("付款成功！");
				}else{
					RedisUtil.lpush("TransAA_"+transformAA.getId(),String.valueOf(amount));
					return YxUtil.createFail("付款失败！");
				}
			} catch (IOException e) {
				RedisUtil.lpush("TransAA_"+transformAA.getId(),String.valueOf(amount));
				return YxUtil.createFail("付款失败！");
			}
		}
		return YxUtil.createFail("AA收款已经结束");
	}
	
	public ResponseData aaTransDetail(long userId,long transId){
		ImTransformAA transformAA=(ImTransformAA) this.queryForObject("from ImTransformAA where id=?", transId);
		if (transformAA==null) {
			return YxUtil.createFail("查询失败");
		}
		ImTransformAARecord record=(ImTransformAARecord) this.queryForObject("from ImTransformAARecord where userId=? and destId=?", userId,transId);
		List records=this.queryForObjListBySql("select aar.*,u.headUrl,u.name from im_transform_aa_record aar left join im_user u on u.id=aar.userId where aar.destId=?", transId);
		Map map=new HashMap<>();
		map.put("transInfo", transformAA);
		map.put("records", records);
		map.put("isPayed", record!=null?1:0);
		return YxUtil.createSuccessData(map);
	}

	public boolean aaTransRun(long userId,long destId,BigDecimal amount) throws IOException{
		if (!aLock) {
			aLock=true;
			ImUser destUser = (ImUser) userService.getImUser(destId);

			// 付款人，保存到交易记录
			ImWalletHistory fromWalletHis = new ImWalletHistory();
			fromWalletHis.setAmount(amount);
			fromWalletHis.setDestId(destId);
			fromWalletHis.setDestType(IMConstants.MSG_FROM_P2P);
			fromWalletHis.setMoneyDirect(-1);
			fromWalletHis.setMoneyType(WalletConstants.AA_TRANSFORM_SEND);
			fromWalletHis.setOccurTime(System.currentTimeMillis());
			fromWalletHis.setUserId(userId);
			fromWalletHis.setContent(destUser.getName());
			this.save(fromWalletHis);

			// 付款人，更新wallet
			walletService.updateWallet(userId, amount, -1);

			
			ImUser fromUser = (ImUser) userService.getImUser(userId);
			// 收款人，保存到交易记录
			ImWalletHistory walletHis = new ImWalletHistory();
			walletHis.setAmount(amount);
			walletHis.setDestId(userId);
			walletHis.setDestType(IMConstants.MSG_FROM_P2P);
			walletHis.setMoneyDirect(1);
			walletHis.setMoneyType(WalletConstants.AA_TRANSFORM_RECEVIE);
			walletHis.setOccurTime(System.currentTimeMillis());
			walletHis.setUserId(destId);
			walletHis.setContent(fromUser.getName());
			this.save(walletHis);

			// 收款人，更新wallet
			walletService.updateWallet(destId, amount, 1);

			// 通知收款人，已到账
			ImMessage msg;
			try {
				msg = msgFactory.receiveMoneyNotice(userId,destId,amount);
				msg.setFromId(userId);
				msg.setDestId(destId);
				chatService.storeMsgAndNotifyImServer(msg, destId);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				aLock=false;
				return false;
			}
			aLock=false;
		}
		return true;
	}
	
	/**
	 * AA收款 过期线程 
	 * 设置状态
	 * 释放内存
	 *  
	 */
	@Transactional
	public void aaTransReturnThread(){
		if (!aLock) {
			aLock=true;
			List<ImTransformAA> transAAList = (List<ImTransformAA>) this.find("from ImTransformAA where status=0");
			if (transAAList != null) {
				for (ImTransformAA trans : transAAList) {
					long sendTime = trans.getCreateTime();
					long id = trans.getId();

					// 测试时为1分钟
					if (System.currentTimeMillis() - sendTime > WalletConstants.AA_TRANSFORM_TIME_OUT) {
//						System.out.println("开始重置："+id);
						// 更新AA转账状态
						trans.setUpdateTime(System.currentTimeMillis());
						trans.setStatus(2);
						this.save(trans);
						// 释放内存
						RedisUtil.delete(("TransAA_"+id).getBytes());
					}
				}
				aLock=false;
			}
		}
	}
	
	
	/**
	 * 开始群组转账
	 * 
	 * @param userId
	 * @param destId
	 * @param amount
	 * @param msg
	 * @return
	 * @throws IOException
	 */
	public ImTransForm createTransfer(long userId, long destId, BigDecimal amount, String msg,long groupId) throws IOException {
		
		ImUser destUser = userService.getImUser(destId);
		ImTransForm trans = new ImTransForm();
		trans.setAmount(amount);
		trans.setDestId(destId);
		trans.setMsg(msg);
		trans.setSendTime(System.currentTimeMillis());
		trans.setStatus(1);
		trans.setUserId(userId);
		trans.setGroupId(groupId);
		this.save(trans);

		// 保存到交易记录
		ImWalletHistory walletHis = new ImWalletHistory();
		walletHis.setAmount(amount);
		walletHis.setDestId(destId);
		walletHis.setDestType(IMConstants.MSG_FROM_GROUP);
		walletHis.setMoneyDirect(-1);
		walletHis.setMoneyType(MoneyConstants.BILLING_SEND_TRANSFER);
		walletHis.setOccurTime(System.currentTimeMillis());
		walletHis.setUserId(userId);
		walletHis.setContent(destUser.getName());
		this.save(walletHis);

		// 更新wallet
		walletService.updateWallet(userId, amount, -1);

		// 通知好友有转账信息
		ImMessage imMsg = msgFactory.transferNotice(trans.getId(), userId, destId, msg, trans.getAmount(),groupId);
//		chatService.storeMsgAndNotifyImServer(imMsg, destId);

		
		//	通知群成员有转账消息
		
		List<Map<String, Object>> members=groupService.getAllMemberFromCache(groupId);
		//通知群成员， 有人被删除了
		
		for(Map<String, Object> member:members){
			if (Long.parseLong(member.get("userId").toString())!=userId) {
				chatService.storeMsgAndNotifyImServer(imMsg, Long.parseLong(member.get("userId").toString()));
			}
		}
		
				
		
		return trans;
	}
}
