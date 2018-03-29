package com.yx.base.service.chat;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.corundumstudio.socketio.AckCallback;
import com.corundumstudio.socketio.SocketIOClient;
import com.framework.util.RedisUtil;
import com.framework.util.Utils;
import com.google.common.collect.ImmutableList;
import com.yx.base.model.ImMessage;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.RobotMsg;
import com.yx.base.service.friend.FriendService;
import com.yx.base.service.group.GroupService;

@Service
@SuppressWarnings({ "rawtypes" })
public class ChatService {


	@Autowired
	private GroupService groupService;
	
	@Autowired
	private FriendService friendService;

	@Autowired
	private ClientMapService clientService;

	@Autowired
	private MsgStoreAndNotify msgNotify;

	/**
	 * 推送消息
	 */
	public void pushMessage() {
		ImmutableList<Long> rows = ImmutableList.copyOf(ClientMapService.clientMap.rowKeySet());
		ImmutableList<Integer> cols = ImmutableList.copyOf(ClientMapService.clientMap.columnKeySet());

		for (long userId : rows) {
			for (int deviceId : cols) {
				try {
					SocketIOClient client = ClientMapService.clientMap.get(userId, deviceId);
					if (client == null) {
						ClientMapService.clientMap.remove(userId, deviceId);
						continue;
					}
					sendAndRemove(userId, client);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("推送消息时，取不到client对象");
					continue;
				}
			}
		}
		rows = null;
		cols = null;
	}

	public List<String> getMessage(long userId) {
		String key = "msg_" + userId;
		return RedisUtil.lrange(key, 0, -1);
	}

	/**
	 * 推送消息--子方法，并且成功后移除redis消息
	 * @param userId
	 * @param client
	 */
	public void sendAndRemove(long userId, SocketIOClient client) {
		String key = "msg_" + userId;
		List<String> list = getMessage(userId);
		if (list != null) {
			for (int i = list.size() - 1; i >= 0; i--) {
				ImMessage msg = JSON.parseObject(list.get(i), ImMessage.class);

				System.out.println(userId + "取消息出队列，开始推送消息，需要消息确认" + JSONObject.toJSONString(msg));
				RedisUtil.rpop(key);
				client.sendEvent(IMConstants.IM_EVENT_CHAT, new AckCallback<String>(String.class, 18) {
					@Override
					public void onSuccess(String result) {
						System.out.println("确认收到消息msgId:" + result);
					}

					
				}, msg);

				//给他的其它在线设备推送
				pushOtherDevice(client,userId,msg);
			}
		}
	}

	

	public void sendRobotMsg(SocketIOClient client, ImMessage data) {
		data.setFromType(IMConstants.MSG_FROM_P2P);
		long toId = data.getDestId();
		long fromId = data.getFromId();
		data.setMsgId(Utils.getUUID());
		data.setMessageType(2);
		data.setSendTime(System.currentTimeMillis());
		data.setFromId(toId);
		data.setDestId(fromId);
		try {
			String robotContent = msgNotify
					.httpRequest("http://api.qingyunke.com/api.php?key=free&appid=0&msg=" + data.getContent());
			RobotMsg response = JSON.parseObject(robotContent, RobotMsg.class);
			if (response.getCode() == 0) {
				data.setContent(response.getContent());
			} else {
				data.setContent("你萌萌哒。。。");
			}
		} catch (Exception e) {
			data.setContent("你说的东西好难懂哦。。。");
		}
		/*client.sendEvent(IMConstants.IM_EVENT_CHAT, new AckCallback<String>(String.class, 18) {
			@Override
			public void onSuccess(String result) {
				System.out.println("确认收到消息msgId:" + result);
			}

			@Override
			public void onTimeout() {
				System.out.println("机器人,推送消息超时18。。。重新放回队列");
			}
		}, data);*/
	}

	/**
	 * 
	 * @param client
	 * @param isMe
	 * @param data
	 */
	public void pushOtherDevice(SocketIOClient client,long userId,ImMessage data){
		if(IMConstants.SPEC_MSG_TYPE.contains(data.getMessageType())){
			List<SocketIOClient> clients=clientService.getOtherClient(userId, client);
			for(SocketIOClient otherClient:clients){
				otherClient.sendEvent(IMConstants.IM_EVENT_CHAT,new AckCallback<String>(String.class, 18) {
					@Override
					public void onSuccess(String result) {
						System.out.println("确认收到同步消息msgId:" + result);
					}

					@Override
					public void onTimeout() {
						System.out.println("推送给我的其它设备超时，可能已经下线");
					}
				},data);
			}
		}
	}
	
	/**
	 * 处理websocket收到的消息
	 * 
	 * @param client
	 * @param data
	 */
	public void handleRecMessage(SocketIOClient client, ImMessage data) {
		if (data != null) {
			long deviceSendtime=data.getSendTime();
			data.setSendTime(System.currentTimeMillis());
			data.setReceiveTime(System.currentTimeMillis());
			
			/////我的其它设备//////
			pushOtherDevice(client,data.getFromId(),data);
						
			if (data.getMessageType() == 1) {
				System.out.println("又发了一次上线，取消ready,用户：" + data.getFromId() + "上线");
			} else if (data.getFromType() == IMConstants.MSG_FROM_P2P) {

				// 如果 是机器人账号
				if (data.getDestId() == 17078 || data.getDestId() == 17079 || data.getDestId() == 17080
						|| data.getDestId() == 17081 || data.getDestId() == 17082 || data.getDestId() == 17083
						|| data.getDestId() == 17084 || data.getDestId() == 17085 || data.getDestId() == 17086
						|| data.getDestId() == 17087 || data.getDestId() == 17088 || data.getDestId() == 17089) {
					this.sendRobotMsg(client, data);

					return;
				}
				// 如果不是好友
				int fstatus=friendService.friendCheck(data.getFromId(), data.getDestId());
				if ((fstatus==-1||fstatus==0)&&(data.getMessageType()!=33)) {
					ImMessage noticemessage=new ImMessage();
					noticemessage.setFromId(data.getDestId());
					noticemessage.setDestId(data.getFromId());
					noticemessage.setContent("{\"msgId\":\""+data.getMsgId()+"\",\"msgType\":\""+fstatus+"\"}");
					noticemessage.setMessageType(66);
					noticemessage.setFromType(IMConstants.MSG_FROM_P2P);
					noticemessage.setMsgId(Utils.getUUID());
					noticemessage.setSendTime(deviceSendtime+1);
					System.out.println("收到消息时间是："+data.getSendTime()+"回复时间是："+noticemessage.getSendTime());
					client.sendEvent(IMConstants.IM_EVENT_CHAT, new AckCallback<String>(String.class, 18) {
						@Override
						public void onSuccess(String result) {
							System.out.println("确认收到消息msgId:" + result);
						}
					}, noticemessage);
				}else{
					long toId = data.getDestId();
					msgNotify.storeMsgAndNotifyImServer(data, toId);
				}
			} else if (data.getFromType() == IMConstants.MSG_FROM_GROUP) {
				// 群聊天

				List<Map<String, Object>> list;
				try {
					list = groupService.getAllMemberFromCache(data.getDestId());
					for (Map map : list) {
						long userId = Long.parseLong(map.get("userId").toString());
						if (data.getFromId() != userId) {
							msgNotify.storeMsgAndNotifyImServer(data, userId);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}
	}

	public static void main(String args[]) throws Exception {

	}

}
