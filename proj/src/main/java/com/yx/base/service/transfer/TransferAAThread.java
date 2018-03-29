package com.yx.base.service.transfer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TransferAAThread extends Thread {

	public static boolean isRun=true;
	
	@Autowired
	private TransferService transService;

	/**
	 * 转账超时线程
	 */
	public void run() {
		System.out.println("AA转账超时线程开始。。。。");
		while (isRun) {
			try {
				Thread.sleep(1000*60);
				transService.aaTransReturnThread();
			} catch (Exception e) {
				System.out.println("AA转账超时检测线程异常：" + e.toString());
			}
		}
	}
}
