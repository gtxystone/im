package com.yx.base.service.chat;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.corundumstudio.socketio.SocketIOClient;
import com.framework.util.Utils;
import com.google.common.collect.HashBasedTable;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.Table;
import com.yx.base.model.ImMessage;
import com.yx.base.parameter.IMConstants;

@Service
public class ClientMapService {

	@Autowired
	private UserRedisMap userRedisMap;
	
	@Autowired
	private MsgStoreAndNotify notify;
	
	public final static Table<Long, Integer, SocketIOClient> clientMap = HashBasedTable.create();
	
	public void hasOnline(final long userId){
		String ip=userRedisMap.getUserIp(userId);
		String url = "http://" + ip + ":19569/chat/notifyOffline?userId="+userId;
		notify.httpRequest(url);
	}

	public void addClient(final long userId,final  int device, SocketIOClient client) {
		
		userRedisMap.addUserIpToRedis(userId);
		if (userId < 0 || client == null) {
			System.out.println("添加 到client map时参数不对="+userId+","+client);
			return;
		}

		ClientMapService.clientMap.put(userId, device, client);
		
	}
	

	public void removeClient(SocketIOClient client) {
		ImmutableList<Long> rows=ImmutableList.copyOf(ClientMapService.clientMap.rowKeySet());
		ImmutableList<Integer> cols=ImmutableList.copyOf(ClientMapService.clientMap.columnKeySet());		
		for (long userId : rows) {
			for (int deviceId : cols) {
				SocketIOClient temp = ClientMapService.clientMap.get(userId, deviceId);
				if (temp != null && temp.equals(client)) {
					// 清理redis的在线用户
					userRedisMap.removeUserIpFromRedis(userId);
					// 清理内存列表
					ClientMapService.clientMap.remove(userId, deviceId);
					return;
				}
			}
		}
		rows=null;
		cols=null;
	}

	public int getDeviceId(SocketIOClient client) {
		ImmutableList<Integer> cols=ImmutableList.copyOf(ClientMapService.clientMap.columnKeySet());
		ImmutableList<Long> rows=ImmutableList.copyOf(ClientMapService.clientMap.rowKeySet());
		for (long userId : rows) {
			for (int deviceId : cols) {
				SocketIOClient temp = ClientMapService.clientMap.get(userId, deviceId);
				if (temp != null && temp.equals(client)) {
					return deviceId;
				}
			}
		}		  		
		rows=null;
		cols=null;
		return 999;
	}
	
	public long getUserId(SocketIOClient client) {
		ImmutableList<Integer> cols=ImmutableList.copyOf(ClientMapService.clientMap.columnKeySet());
		ImmutableList<Long> rows=ImmutableList.copyOf(ClientMapService.clientMap.rowKeySet());
		for (long userId : rows) {
			for (int deviceId : cols) {
				SocketIOClient temp = ClientMapService.clientMap.get(userId, deviceId);
				if (temp != null && temp.equals(client)) {
					return userId;
				}
			}
		}		  		
		rows=null;
		cols=null;
		return 0l;
	}
	
	/**
	 * 获取其它在线的终端
	 * @param userId
	 * @param client
	 * @return
	 */
	public List<SocketIOClient> getOtherClient(long userId,SocketIOClient client){
		List<SocketIOClient> clients=new ArrayList<SocketIOClient>();
		
		SocketIOClient pcClient=ClientMapService.clientMap.get(userId, IMConstants.DEV_PC);
		if(pcClient!=null&&pcClient!=client){
			clients.add(pcClient);
		}
		
		SocketIOClient androidClient=ClientMapService.clientMap.get(userId, IMConstants.DEV_ANDROID);
		if(androidClient!=null&&androidClient!=client){
			clients.add(androidClient);
		}
		
		SocketIOClient iosClient=ClientMapService.clientMap.get(userId, IMConstants.DEV_IOS);
		if(iosClient!=null&&iosClient!=client){
			clients.add(iosClient);
		}		
		
		return clients;
	}
	
	/**
	 * 
	 * @param args
	 */
	public static void main(String args[]){
		Integer[] SPEC_MSG_TYPE=new Integer[]{2,3,4,16,17,18,28,29,30,32,33,34,35};
		
		List<Integer> list = Arrays.asList(2,3,4,16,17,18,28,29,30,32,33,34,35);
		System.out.println(list.contains(2));
	}

	/*public void loop(){
		Enumeration<Long> userIds = ClientMapService.clientMap.keys();
		while (userIds.hasMoreElements()) {
			long userId = userIds.nextElement();
			ConcurrentHashMap<Integer, SocketIOClient> deviceMap = ClientMapService.clientMap.get(userId);
			Enumeration<Integer> deviceIds = deviceMap.keys();
			while (deviceIds.hasMoreElements()) {
				int deviceId = deviceIds.nextElement();
				SocketIOClient temp = deviceMap.get(deviceId);
				if (temp != null && temp.equals(client)) {
					return deviceId;
				}

			}
		}
	}
	*/
}
