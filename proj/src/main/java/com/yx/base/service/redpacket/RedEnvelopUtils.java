package com.yx.base.service.redpacket;

import java.math.BigDecimal;
import java.math.MathContext;

public class RedEnvelopUtils {

	/**
	 * 本局最大红包金额
	 */
	public static BigDecimal maxMoney(RedEnvelop red){
		return red.getSumMoney().divide(new BigDecimal(red.getCount()),MathContext.DECIMAL128).multiply(new BigDecimal(2));
	}
	
	/**
	 * 剩下的单个红包平均值
	 */
	public static BigDecimal leftAvgMoney(RedEnvelop red){
		return red.getSurplusMoney().divide(new BigDecimal(red.getSurplusCount()),MathContext.DECIMAL128).multiply(new BigDecimal(2));
	}
}
