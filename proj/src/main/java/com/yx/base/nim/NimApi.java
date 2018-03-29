package com.yx.base.nim;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Firrela
 * @time 2016/3/7.
 */
public class NimApi {

    private static Logger logger = LoggerFactory.getLogger(NimApi.class);

    private static String APPKEY = "78b5be59096a36860a7e181f50d8cd11";  //AppKey

	private static String SECRET = "4a4a5fc940d8";  //AppSecret
	

	public static  void setAPPKEY(String aPPKEY) {
		APPKEY = aPPKEY;
	}

	public static  void setSECRET(String sECRET) {
		SECRET = sECRET;
	}

    public static final void main(String[] args) throws IOException {
//        String res = createUser("HelloWorld", "名字", UUIDUtil.getUUID());

//        System.out.println(res);
        //TODO: 对结果的业务处理，如解析返回结果，并保存成功注册的用�?
    }

    /**
     * 创建网易云信accid
     * @param accid
     * @param name
     * @param token
     * @return
     * @throws IOException
     */
    public static  String createUser(String accid, String name, String token) throws IOException {
        String url = "https://api.netease.im/nimserver/user/create.action";
        List<NameValuePair> params = new ArrayList<NameValuePair>();

        params.add(new BasicNameValuePair("accid", accid));
        params.add(new BasicNameValuePair("name", name));
        params.add(new BasicNameValuePair("token", StringUtils.isBlank(token)?UUIDUtil.getUUID():token));

        //UTF-8编码,解决中文问题
        HttpEntity entity = new UrlEncodedFormEntity(params, "UTF-8");

        String res = NIMPost.postNIMServer(url, entity, APPKEY, SECRET);
        logger.info("createUser httpRes: {}", res);
        return decodeRes(res,"info");
    }
    
    /**
     * 更新用户token
     * @param accid
     * @return
     * @throws IOException
     */
    public static  String updateToken(String accid) throws IOException {
        String url = "https://api.netease.im/nimserver/user/refreshToken.action";
        List<NameValuePair> params = new ArrayList<NameValuePair>();

        params.add(new BasicNameValuePair("accid", accid));

        //UTF-8编码,解决中文问题
        HttpEntity entity = new UrlEncodedFormEntity(params, "UTF-8");

        String res = NIMPost.postNIMServer(url, entity, APPKEY, SECRET);
        logger.info("updateToken httpRes: {}", res);
        return decodeRes(res,"info");
    }
    
    public static String channelCreate(String name,int type) throws IOException {
        String url = "https://api.netease.im/nimserver/user/refreshToken.action";
        List<NameValuePair> params = new ArrayList<NameValuePair>();

        params.add(new BasicNameValuePair("name", name));
        params.add(new BasicNameValuePair("type", String.valueOf(type)));

        //UTF-8编码,解决中文问题
        HttpEntity entity = new UrlEncodedFormEntity(params, "UTF-8");

        String res = NIMPost.postNIMServer(url, entity, APPKEY, SECRET);
        logger.info("updateToken httpRes: {}", res);
        return decodeRes(res,"info");
    }
    
    /**
     * 更新直播频道
     * @param name
     * @param cid
     * @param type
     * @return
     * @throws IOException
     */
    public static String channelUpdate(String name,String cid,int type) throws IOException {
        String url = "https://api.netease.im/nimserver/user/refreshToken.action";
        List<NameValuePair> params = new ArrayList<NameValuePair>();

        params.add(new BasicNameValuePair("name", name));
        params.add(new BasicNameValuePair("cid", cid));
        params.add(new BasicNameValuePair("type", String.valueOf(type)));

        //UTF-8编码,解决中文问题
        HttpEntity entity = new UrlEncodedFormEntity(params, "UTF-8");

        String res = NIMPost.postNIMServer(url, entity, APPKEY, SECRET);
        logger.info("updateToken httpRes: {}", res);
        return decodeRes(res,"info");
    }
    
    
    /**
     * 删除频道
     * @param cid
     * @return
     * @throws IOException
     */
    public static String channelDelete(String cid) throws IOException {
        String url = "https://api.netease.im/nimserver/user/refreshToken.action";
        List<NameValuePair> params = new ArrayList<NameValuePair>();

        params.add(new BasicNameValuePair("cid", cid));

        //UTF-8编码,解决中文问题
        HttpEntity entity = new UrlEncodedFormEntity(params, "UTF-8");

        String res = NIMPost.postNIMServer(url, entity, APPKEY, SECRET);
        logger.info("updateToken httpRes: {}", res);
        return decodeRes(res,"info");
    }
    
    
    private static String decodeRes(String res,String key){
		if (StringUtils.isBlank(res)) {
			return "";
		}
		JSONObject json=JSONObject.parseObject(res);
		if (json.get("code")==null||json.get(key)==null) {
			return "";
		}
		String code=json.get("code").toString();
		if (code.equals(new String("200"))) {
			return JSON.toJSONString(json.get(key));
		}else{
			return "";
		}
	}
}
