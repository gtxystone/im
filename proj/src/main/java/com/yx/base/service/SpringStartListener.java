package com.yx.base.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import com.yx.base.service.chat.ChatConfig;
import com.yx.base.service.redpacket.RedPacketThread;
import com.yx.base.service.transfer.TransferAAThread;
import com.yx.base.service.transfer.TransferThread;
import com.yx.base.service.user.NumberThread;
import com.yx.base.thread.NotifyProcessor;

@Service
public class SpringStartListener implements ApplicationListener<ContextRefreshedEvent>{

	@Autowired
	private TaskExecutor executor;
	
	@Autowired
	private ChatConfig config;
	
	@Autowired
	private RedPacketThread redPacketThread;
	
	@Autowired
	private TransferThread transThread;
	
	@Autowired
	private NumberThread numberThread;
	
	@Autowired
	private TransferAAThread transferAAThread;
	


	int i=0;
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		
		if(i==1){
			
			executor.execute(new NotifyProcessor());
			
			if(config.getEnableredback()){
				executor.execute(redPacketThread);
			}
			if(config.getEnabletransback()){
				executor.execute(transThread);
			}	
			executor.execute(numberThread);
			executor.execute(transferAAThread);
		}		
		i++;	
		
	}	
	
	
}
