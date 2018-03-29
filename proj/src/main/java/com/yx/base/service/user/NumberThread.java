package com.yx.base.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yx.base.service.pay.PayService;

/**
 * 检查红包是否超时，做回退处理
 * @author jack
 *
 */
@Service
public class NumberThread extends Thread{
	
	public static boolean isRun=true;
	
	@Autowired
	private PayService payService;
	
	/**
	 * 红包超时线程
	 */
	public void run() {
		
		System.out.println("靓号回收线程开始。。。。");
		
		while (isRun) {
			try {
				Thread.sleep(1000*60*10);
				payService.numberReturnBack();
			} catch (Exception e) {
				System.out.println("靓号回收线程异常：" + e.toString());				
			}
		}
		
	}
}
