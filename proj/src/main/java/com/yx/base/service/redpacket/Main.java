package com.yx.base.service.redpacket;

import java.math.BigDecimal;


public class Main {

	public static void main(String[] args) {
		RedEnvelop red = new RedEnvelop(10, 100f);

		System.err.println("红包总数：" + red.getCount());
		System.err.println("红包总金额：" + red.getSumMoney().floatValue());

		BigDecimal b = new BigDecimal(0);
		for (int i = 0; i < red.getCount(); i++) {
			BigDecimal m = red.nextRed();
			b = b.add(m);
			System.out.println("第" + (i + 1) + "个红包：" + m.floatValue());
		}
		System.err.println("已领取红包金额：" + b.floatValue());

	}
}
