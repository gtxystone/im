package com.yx.base.parames;

import java.util.ArrayList;
import java.util.List;

public class ImConstants {
	
	public static final int RED_PACKET_TYPE_COMMAND=3;// 口令红包
	
	public static final int MSG_TYPE_GROUP_HEAD = 46;//	  群头像修改
	
	public static final int MSG_TYPE_GROUP_NOTE_NEW = 47;//		新群公告
	
	public static final int MSG_TYPE_GROUP_NOTE_UPDATE = 48;//  群公告修改
	
	public static final int MSG_TYPE_FEED_AT = 49;//  朋友圈提到了谁
	
	public static final int MSG_TYPE_COMMAND_RED_NOTICE=50;//  口令红包抢光通知
	
	public static final int NOTICE_OF_GROUP_DISMISS=51;// 群解散通知
	
	public static final int NOTICE_OF_GROUP_TRANS=52;// 群转让邀请
	
	public static final int NOTICE_OF_GROUP_TRANS_YES=53;// 群转让邀请同意
	
	public static final int NOTICE_OF_GROUP_TRANS_NO=54;// 群转让邀请拒绝
	
	public static final int NOTICE_OF_GROUP_ADMIN_SET=55;// 群成员成为管理员
	
	public static final int NOTICE_OF_GROUP_DESCRIPTIONS=56;// 群简介更新
	
	public static final int NOTICE_OF_GROUP_ADMIN_CANCEL=57;// 群成员取消管理员
	
	public static final int NOTICE_OF_GROUP_EXPIRE=58;// 群到期提醒
	
	public static final int NOTICE_OF_GROUP_REQUEST=59;// 请求加群
	
	public static final int NOTICE_OF_GROUP_REQUEST_YES=60;// 同意加群
	
	public static final int NOTICE_OF_GROUP_REQUEST_NO=61;// 拒绝加群
	
	public static final int NOTICE_OF_GROUP_SILENCE_YES=62;// 禁言成功
	
	public static final int NOTICE_OF_GROUP_SILENCE_NO=63;// 取消禁言
	
	public static final int NOTICE_OF_GROUP_MEMBER_REMOVE=64;// 群成员被删除
	
	public static final int NOTICE_OF_GROUP_UPDATE_EXPIRE=65;// 群到期时间更新
	
	public static final int MSG_OF_NO_FRIEND=66;// 验证非通过消息 拉黑消息 或者非好友
	
	public static final int NOTICE_OF_HELLO=67;// 打招呼消息
	
	//设置APPID/AK/SK
    public static final String BAIDU_APP_ID = "10019750";
    
    public static final String BAIDU_API_KEY = "rUHQRermbFl91SU16Rs8q9jc";
    
    public static final String BAIDU_SECRET_KEY = "4a1a8527f73ddea6a6e5d67a575ab393";
    
    public static final String AIPAY_ORDER_KEY="alipayOrder";
    
    public static final String AIPAY_ORDER_SUCCUSS_KEY="alipaySuccess";
    
    public static final String WXPAY_ORDER_KEY="wxpayOrder";
    
    public static final String WXPAY_ORDER_SUCCUSS_KEY="wxpaySuccess";
    
	
	@SuppressWarnings("serial")
	public static final List<String> countryCode =new ArrayList<String>(){{
        add("+86");
    }};
    
    // 群返回code码
    public static final int RESPONSE_GROUP_2000=2000;  // 群组不存在或已删除
    
    public static final int RESPONSE_GROUP_2001=2001;  // 无权操作
    
    public static final int RESPONSE_GROUP_2003=2003;  // 用户不是群成员
    
    //  钱包类型
    public static final String IM_NUMBER_KEY="SamNumber";
   
    public static final int MONEY_TYPE_9=9; // 购买靓号
    
    // 分组设置
    public static final int MAX_FRIEND_GROUP=20;
	
}
