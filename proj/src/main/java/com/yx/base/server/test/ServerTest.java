package com.yx.base.server.test;

import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.Transport;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;

@SuppressWarnings("unused")
public class ServerTest {

	

	private static SocketIOServer server = null;

	public static void main(String args[]) {
		Configuration config = new Configuration();
		config.setPort(8888);
		config.setTransports(Transport.WEBSOCKET, Transport.POLLING);
		config.setPingTimeout(11000);
		config.setPingInterval(3000);

		server = new SocketIOServer(config);
		
		server.addConnectListener(new ConnectListener() {
			@Override
			public void onConnect(SocketIOClient client) {
				SendThread sender=new SendThread(client);
				sender.start();
				System.out.println("connection...");
			}
		});

		// 聊天测试
		server.addEventListener("chat", String.class, new DataListener<String>() {
			@Override
			public void onData(SocketIOClient client, String data, AckRequest ackRequest) {
				System.out.println("收到信息。。" + (data));
				ackRequest.sendAckData("服务器确认收到");
				/*
				 * client.sendEvent("chat", data, new
				 * AckCallback<String>(String.class,10){
				 * 
				 * @Override public void onSuccess(String result) {
				 * System.out.println("客户端确认收到=。。" + data); }
				 * 
				 * });
				 */

			}
		});

		server.start();
		System.out.println("测试服务器已经启动");

	}

}
