package com.yx.base.service.redpacket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 检查红包是否超时，做回退处理
 * @author jack
 *
 */
@Service
public class RedPacketThread extends Thread{
	
	public static boolean isRun=true;
	
	@Autowired
	private RedPacketService redService;
	
	/**
	 * 红包超时线程
	 */
	public void run() {
		
		System.out.println("红包检测线程开始。。。。");
		
		while (isRun) {
			try {
				Thread.sleep(1000*60*5);
				redService.checkAndReturnRed();				
			} catch (Exception e) {
				System.out.println("转账超时检测线程异常：" + e.toString());				
			}
		}
		
	}
}
