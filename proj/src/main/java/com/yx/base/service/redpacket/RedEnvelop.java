package com.yx.base.service.redpacket;

import java.math.BigDecimal;
import java.util.Random;

public class RedEnvelop {

	/**总个数**/
	private int count;
	/**剩下个数**/
	private int surplusCount;
	/**总金额**/
	private BigDecimal sumMoney;
	/**剩下金额**/
	private BigDecimal surplusMoney;
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSurplusCount() {
		return surplusCount;
	}
	public void setSurplusCount(int surplusCount) {
		this.surplusCount = surplusCount;
	}
	public BigDecimal getSumMoney() {
		return sumMoney;
	}
	public void setSumMoney(BigDecimal sumMoney) {
		if(sumMoney.floatValue() <= 0.01f)
			throw new RedException("红包总金额不能小于0.01元");
		this.sumMoney = sumMoney;
	}
	public BigDecimal getSurplusMoney() {
		return surplusMoney;
	}
	public void setSurplusMoney(BigDecimal surplusMoney) {
		this.surplusMoney = surplusMoney;
	}

	public RedEnvelop(int count, float sumMoney) {
		super();
		this.count = count;
		this.surplusCount = this.count;
		this.sumMoney = new BigDecimal(sumMoney);
		this.surplusMoney = this.sumMoney;
	}
	public RedEnvelop() {
		super();
	}


	/**随机种子**/
	public final Random rand = new Random();
	
	/**
	 * 下一个红包
	 * @return 红包金额
	 */
	public BigDecimal nextRed(){
		//抢到的红包
		BigDecimal money = new BigDecimal(0.01);

		//每个人平均的红包
		BigDecimal maxMoney = RedEnvelopUtils.maxMoney(this);
		if(maxMoney.floatValue() < 0.01)
			throw new RedException("每个红包不能少于0.01元");

		//剩下红包的平均值大于0.01元
		BigDecimal leftAvgMoney = RedEnvelopUtils.leftAvgMoney(this);
		
		//随机红包
		if(surplusCount != 1){//不是最后一个红包
			//循环只是为了计算更加精确
			while (true) {
				if(leftAvgMoney.floatValue() > 0.01f){
					// TODO 剩下单个红包平均值大于0.01元就进行随机分配
					
					//计算浮动范围   》》  (剩下金额 / 剩下人数) * 几人次
					BigDecimal d1 = BigDecimalUtil.multiply(BigDecimalUtil.divide(surplusMoney, new BigDecimal(surplusCount)), new BigDecimal(3));
					
					//计算用户抢到的金额（保留两位小数） 》》 随机数 * 浮动范围
					money = BigDecimalUtil.multiply(new BigDecimal(rand.nextFloat()), d1).setScale(2, BigDecimal.ROUND_HALF_UP);
				}else{
					//剩下单个红包==0.01就分配0.01元
					money = new BigDecimal(0.01);
				}
				
				if(leftAvgMoney.floatValue() > money.floatValue() && money.floatValue() != 0){
					// TODO 如果剩下单个红包平均值大于当前分配的红包金额和当前分配的红包金额!=0元时就说明分配合理，进入下一步，否则重新分配
					break;
				}
			}
		}else {//最后一个红包 
			//(保留两位小数)
			money = surplusMoney.setScale(2,BigDecimal.ROUND_HALF_UP);
		}
		//人数减一
		surplusCount--;
		//计算剩余金额
		surplusMoney = BigDecimalUtil.subtract(surplusMoney, money);
		
		return money;
	}
}
