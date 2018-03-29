package com.yx.im.app;

import javax.annotation.PostConstruct;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.alibaba.fastjson.JSONObject;
import com.corundumstudio.socketio.AckCallback;
import com.corundumstudio.socketio.AckRequest;
import com.corundumstudio.socketio.Configuration;
import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;
import com.corundumstudio.socketio.Transport;
import com.corundumstudio.socketio.listener.ConnectListener;
import com.corundumstudio.socketio.listener.DataListener;
import com.corundumstudio.socketio.listener.DisconnectListener;
import com.framework.util.Utils;
import com.yx.base.model.ImMessage;
import com.yx.base.parameter.IMConstants;
import com.yx.base.service.chat.ChatConfig;
import com.yx.base.service.chat.ChatService;
import com.yx.base.service.chat.ClientMapService;
import com.yx.base.service.chat.IMAuthorizationListener;
import com.yx.base.thread.NotifyProcessor;
import com.yx.base.util.YxUtil;

@org.springframework.context.annotation.Configuration
@EnableAutoConfiguration
@ComponentScan(basePackages = { "com.yx" })
@SpringBootApplication
@EnableScheduling
@EnableAsync
@PropertySource("classpath:imServer.properties")
public class IMApplication extends WebMvcConfigurerAdapter {

	@Autowired
	private TaskExecutor executor;

	@Autowired
	private ChatService chatService;

	@Autowired
	private ClientMapService clientService;

	@Autowired
	private ChatConfig configService;

	private SocketIOServer server = null;

	@Bean
	public TaskExecutor taskExecutor() {
		ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
		executor.setCorePoolSize(5);
		executor.setMaxPoolSize(100);
		executor.setQueueCapacity(25);
		return executor;
	}

	@PostConstruct
	public void init() {
		if (!configService.getEnablesocket()) {
			return;
		}

		Configuration config = new Configuration();
		config.setPort(configService.getSocket());
		config.setTransports(Transport.WEBSOCKET, Transport.POLLING);
		config.setPingTimeout(11000);
		config.setPingInterval(3000);
		config.setAuthorizationListener(new IMAuthorizationListener());

		server = new SocketIOServer(config);

		server.addConnectListener(new ConnectListener() {
			@Override
			public void onConnect(SocketIOClient client) {
				String userIdStr = Utils.decrypt(client.getHandshakeData().getSingleUrlParam("token"));
				String deviceStr = client.getHandshakeData().getSingleUrlParam("device");
				int device = Integer.parseInt(deviceStr);
				long userId=Long.parseLong(userIdStr);
				
				//判断用户是否在线
				SocketIOClient oldClient=ClientMapService.clientMap.get(userId, device);
				if(oldClient!=null){
					ImMessage msg=otherLoginNotice(userId);
					oldClient.sendEvent(IMConstants.IM_EVENT_CHAT,new AckCallback<String>(String.class, 18) {

						@Override
						public void onSuccess(String result) {
							
						}
						
					},msg);
				}
				String now=new DateTime().toString("yyyy-MM-dd HH:mm:ss");
				System.out.println(now+"--用户：" + userId + ",device=" + device + " 连接成功");

				clientService.addClient(userId, device, client);
				// 推送离线消息
				chatService.pushMessage();

			}
		});

		// 聊天
		server.addEventListener(IMConstants.IM_EVENT_CHAT, ImMessage.class, new DataListener<ImMessage>() {
			@Override
			public void onData(SocketIOClient client, ImMessage data, AckRequest ackRequest) {
				System.out.println("收到信息。。" + JSONObject.toJSONString(data));
				ackRequest.sendAckData(YxUtil.createSimpleSuccess(data.getMsgId()));
				System.out.println("回复ack=。。" + data.getMsgId());
				chatService.handleRecMessage(client, data);
			}
		});

		// 心跳
		server.addEventListener(IMConstants.IM_EVENT_HEART, ImMessage.class, new DataListener<ImMessage>() {
			@Override
			public void onData(SocketIOClient client, ImMessage data, AckRequest ackRequest) {

				// 如果是新连接，则放入session list
				if (ClientMapService.clientMap.get(data.getFromId(), data.getDevType()) != client) {
					System.out.println("新的心跳连接被加入：" + data.getFromId());
					clientService.addClient(data.getFromId(), data.getDevType(), client);
				}
				
				String now=new DateTime().toString("yyyy-MM-dd HH:mm:ss");
				System.out.println(now+"--"+data.getFromId()+" 的心跳");

			}
		});

		// close
		server.addDisconnectListener(new DisconnectListener() {

			@Override
			public void onDisconnect(SocketIOClient client) {
				long userId=clientService.getUserId(client);
				String now=new DateTime().toString("yyyy-MM-dd HH:mm:ss");
				System.out.println(now+"--下线"+userId);
				clientService.removeClient(client);
			}

		});
		server.start();
		executor.execute(new NotifyProcessor());
		System.out.println("chatserver init....");
	}

	
	/**
	 * 其它地方登陆，强制下线通知
	 * @param fromId
	 * @return
	 */
	public ImMessage otherLoginNotice(long fromId){
		ImMessage msg=new ImMessage();
		msg.setDestId(fromId);
		msg.setFromId(fromId);
		msg.setFromType(IMConstants.MSG_FROM_SYS);
		msg.setMessageType(IMConstants.MSG_TYPE_OTHER_LOGIN);
		msg.setMsgId(Utils.getUUID());
		msg.setSendTime(System.currentTimeMillis());
		return msg;
	}
	public static void main(String[] args) throws Exception {
		SpringApplication.run(IMApplication.class, args);
	}
}
