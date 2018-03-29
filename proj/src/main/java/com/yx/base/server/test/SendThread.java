package com.yx.base.server.test;

import com.corundumstudio.socketio.AckCallback;
import com.corundumstudio.socketio.SocketIOClient;

public class SendThread extends Thread {
	private SocketIOClient client;

	public SendThread(SocketIOClient client) {
		this.client = client;
	}

	public void run() {
		try {
			Thread.sleep(1000 * 20);
			client.sendEvent("chat", "服务器推送给你的消息，请回复我。", new AckCallback<String>(String.class, 10) {

				@Override
				public void onSuccess(String result) {
					System.out.println("客户端确认收到了。。。");
				}

				@Override
				public void onTimeout() {
					System.out.println("客户端没有确认。。。");
				}

			});
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

	}
}
