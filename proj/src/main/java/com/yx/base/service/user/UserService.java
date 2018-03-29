package com.yx.base.service.user;

import java.io.IOException;
import java.io.Serializable;
import java.io.Writer;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.AbstractDocument.Content;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONString;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.druid.sql.visitor.functions.If;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Value;
import com.fasterxml.jackson.annotation.JsonValue;
import com.framework.model.Page;
import com.framework.service.EntityServiceImpl;
import com.framework.util.RedisUtil;
import com.framework.util.Utils;
import com.google.common.base.Joiner;
import com.google.common.primitives.Longs;
import com.google.gson.JsonObject;
import com.mongodb.Bytes;
import com.yx.base.document.model.Contact;
import com.yx.base.extendmodel.ImDocument;
import com.yx.base.extendmodel.ImRockMessage;
import com.yx.base.extendmodel.ImRockRecord;
import com.yx.base.extendmodel.ImUserContact;
import com.yx.base.extendmodel.ImUserReport;
import com.yx.base.model.ImFriend;
import com.yx.base.model.ImMessage;
import com.yx.base.model.ImUser;
import com.yx.base.model.ImWallet;
import com.yx.base.parames.ImConstants;
import com.yx.base.parameter.Constants;
import com.yx.base.parameter.IMConstants;
import com.yx.base.parameter.RedisKey;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.chat.MsgStoreAndNotify;
import com.yx.base.service.feed.FeedService;
import com.yx.base.service.login.LoginService;
import com.yx.base.service.login.ReadyService;
import com.yx.base.service.message.MessageFactory;
import com.yx.base.service.sms.SmsService;
import com.yx.base.service.tools.ToolsService;
import com.yx.base.service.wallet.WalletService;
import com.yx.base.util.YxUtil;

@SuppressWarnings({ "rawtypes", "unchecked" })
@Service
public class UserService extends EntityServiceImpl {

	@Autowired
	private ReadyService readyService;

	@Autowired
	private MessageFactory msgFactory;

	@Autowired
	private MsgStoreAndNotify chatService;

	@Autowired
	private SmsService smsService;

	@Autowired
	private LoginService loginService;
	
	@Autowired
	private FeedService feedService;

	public ImUser cacheUser(ImUser user) throws IOException {
		byte[] data = Utils.serializeObjectToBytes(user);
		RedisUtil.expired(RedisKey.getImUserKey(user.getId()), 60 * 60 * 24);
		// RedisUtil.set(RedisKey.getImUserKey(user.getId()),data);
		return user;
	}

	public ImUser getImUser(long userId) throws IOException {
		byte[] key = RedisKey.getImUserKey(userId);
		byte[] data = RedisUtil.get(key);
		if (data != null && data.length > 0) {
			return (ImUser) Utils.deserializeObjectFromBytes(data);
		}
		ImUser user = (ImUser) this.findById(ImUser.class, userId);
		if (user != null && user.getId() > 0) {
			cacheUser(user);
		}
		return user;
	}

	public ResponseData doLogin(String mobile, String pwd, HttpServletRequest request, int device,String code,String UUID) {
		HashMap<String, String> data = new HashMap<String, String>();

//		HashMap<String, Object> user = (HashMap<String, Object>) this
//				.queryForObjectBySql("select * from im_user where mobile=? or imNumber=?", mobile.contains("+86")?mobile:(code+mobile),mobile.replace("+86", ""));
		HashMap<String, Object> user = (HashMap<String, Object>) this
				.queryForObjectBySql("select * from im_user where mobile=? ", mobile.contains("+86")?mobile:(code+mobile));
		if (user == null || user.get("id") == null) {
			data.put("info", "用户不存在");
			return YxUtil.getResponse(2, data);
		}
//		if (!loginService.userLimit(Long.parseLong(user.get("id").toString()))) {
//			return YxUtil.createFail("服务器连接失败");
//		}
		String dbPwd = user.get("pwd").toString();
		if (!pwd.equals(dbPwd)) {
			data.put("info", "密码错误");
			return YxUtil.getResponse(3, data);
		}

		if (!StringUtils.isBlank(UUID)) {
			byte[] bytes=RedisUtil.hget("loginInfo".getBytes(), user.get("id").toString().getBytes());
			String rUUID=bytes!=null?new String(bytes):"";
			if (rUUID.equals(UUID)||StringUtils.isBlank(rUUID)) {
				if(StringUtils.isBlank(rUUID))RedisUtil.hset("loginInfo".getBytes(), user.get("id").toString().getBytes(), UUID.getBytes());
//		 		同一设备不通知下线
				System.out.println("UUID 相同");
			}else{
				RedisUtil.hset("loginInfo".getBytes(), user.get("id").toString().getBytes(), UUID.getBytes());
				HashMap<String, Object> content=new HashMap<>();
				content.put("UUID", UUID);
				ImMessage message=msgFactory.otherLoginNotice(Long.parseLong(user.get("id").toString()),JSON.toJSONString(content));
				chatService.storeMsgAndNotifyImServer(message, Long.parseLong(user.get("id").toString()));
			}
		}else{
			chatService.noticeOffline(Long.parseLong(user.get("id").toString()));
		}
		data.put("imServerUrl", loginService.getImServiceUrl(request, device));
		data.put("token", Utils.encrypt(user.get("id").toString()));
		System.out.println("登陆信息=" + JSON.toJSONString(data));

		return YxUtil.createSuccessData(data);
	}

	public void initBalance(long userId) {
		ImWallet wallet = new ImWallet();
		wallet.setMoney(new BigDecimal("0"));
		wallet.setStatus(1);
		wallet.setUserId(userId);
		this.save(wallet);
	}

	public void initTestFriend(long userId) throws IOException {
		long[] destIds = { 17068, 17086 };
		for (long id : destIds) {
			addFriend(userId, id, true);
		}

	}

	/**
	 * 获取黑名单
	 * 
	 * @param userId
	 * @return
	 */
	public List getBlackList(long userId) {
		List list = queryForObjListBySql(
				"select a.remark,a.isBlack,a.receiveTip,b.id,name,nickName,mobile,mail,sex,birthday,sign,province,isOnline,city,district,b.createTime,status,detail,headUrl from im_friend a left join im_user b on(a.friendId=b.id) where a.userId=? and a.isFriend=1 and a.isBlack=1",
				userId);
		return list;
	}

	/**
	 * 移出 黑名单
	 * 
	 * @param userId
	 * @param destId
	 * @return
	 * @throws IOException
	 */
	public int removeBlack(long userId, long destId) throws IOException {
		int row = this.updateBySql("update im_friend set isBlack=0 where userId=? and friendId=?", userId, destId);
		readyService.cacheFriendInfo(userId);
		return row;
	}

	/**
	 * 获取 在线用户列表
	 * 
	 * @return
	 */
	public Map<String, String> getOnlineUserList() {
		return RedisUtil.hgetAll(Constants.USER_IP_KEY);
	}

	public List<ImFriend> getFriends(long userId) {
		List<ImFriend> friends = (List<ImFriend>) this.find("from ImFriend where isFriend=1 and userId=?", userId);
		for(ImFriend friend:friends){
			byte[] key=("friends_"+userId).getBytes();
			RedisUtil.sadd(key, Longs.toByteArray(friend.getFriendId()));			
		}
		
		return friends;
	}
	
	/**
	 * 获取好友id字符串
	 * @param userId
	 * @return
	 */
	public String getFriendsIds(long userId){
		List<ImFriend> friends = (List<ImFriend>) this.find("from ImFriend where isFriend=1 and userId=?", userId);
		List idList=new ArrayList<Long>();
		for(ImFriend member:friends){
			idList.add(member.getId());
		}
		if(idList.size()>0){
			String idStr=Joiner.on(",").join(idList);
			return idStr+","+userId;
		}else{
			return ""+userId;
		}		
		
	}
	
	
	/**
	 * 好友交集
	 * @param userId
	 * @param friendId
	 * @return
	 */
	public Set<byte[]> getMixFriend(long userId,long friendId,long replyUserId){
		byte[] userKey=("friends_"+userId).getBytes();
		byte[] friendKey=("friends_"+friendId).getBytes();
		byte[] replyKey=("friends_"+replyUserId).getBytes();
		if(replyUserId>0){
			getFriends(replyUserId);
			return RedisUtil.sinter(userKey,friendKey,replyKey);
		}else{
			return RedisUtil.sinter(userKey,friendKey);
		}
		
	}
	
	@Transactional
	public void delUser(long userId, long destId) throws IOException {
		// 删除好友
		updateBySql("delete from im_friend where userId=? and	friendId=?", userId, destId);
		updateBySql("delete from im_friend where friendId=? and userId=?", userId, destId);
		// 删除置顶
		updateBySql("delete from im_top where userId=? and destId=? and destType=1", userId, destId);
		updateBySql("delete from im_top where destId=? and userId=? and destType=1", userId, destId);

		readyService.cacheFriendInfo(userId);
		readyService.cacheFriendInfo(destId);
		
		//删除好友缓存
		byte[] key=("friends_"+userId).getBytes();
		RedisUtil.delete(key);
		key=("friends_"+destId).getBytes();
		RedisUtil.delete(key);
		
		//删除相互的朋友圈
		feedService.deleteFriendFeed(userId, destId);

		ImMessage msg = msgFactory.delFriendNotice(userId, destId);
		chatService.storeMsgAndNotifyImServer(msg, destId);
	}

	public void addFriend(long userId, long destId, boolean isDouble) throws IOException {
		if (isDouble) {
			ImFriend friend = new ImFriend();
			friend.setCreaterId(userId);
			friend.setCreateTime(System.currentTimeMillis());
			friend.setFriendId(destId);
			friend.setIsBlack(0);
			friend.setIsFriend(1);
			friend.setReceiveTip(1);
			friend.setUserId(userId);
			updateBySql("delete from im_friend where userId=? and friendId=?", userId, destId);
			save(friend);

			ImFriend friend2 = new ImFriend();
			BeanUtils.copyProperties(friend, friend2);
			friend2.setUserId(destId);
			friend2.setFriendId(userId);
			updateBySql("delete from im_friend where userId=? and friendId=?", destId, userId);
			save(friend2);

		} else {
			ImFriend friend = new ImFriend();
			friend.setCreaterId(userId);
			friend.setCreateTime(System.currentTimeMillis());
			friend.setFriendId(destId);
			friend.setIsBlack(0);
			friend.setIsFriend(0);
			friend.setReceiveTip(1);
			friend.setUserId(userId);
			updateBySql("delete from im_friend where userId=? and friendId=?", userId, destId);
			save(friend);

			ImFriend friend2 = new ImFriend();
			BeanUtils.copyProperties(friend, friend2);
			friend2.setUserId(destId);
			friend2.setFriendId(userId);
			updateBySql("delete from im_friend where userId=? and friendId=?", destId, userId);
			save(friend2);
		}

		readyService.cacheFriendInfo(userId);
		readyService.cacheFriendInfo(destId);
	}

	public int updateAuth(long userId, String realName, String validateNum, String idNo, String mobile)
			throws IOException {
		int row = 0;
		ImUser user = this.getImUser(userId);
		if (user != null && smsService.equalValidate(mobile, validateNum)) {
			user.setIdNo(idNo);
			user.setIsAuth(1);
			user.setRealName(realName);
			this.update(user);
			row = 1;
		}
		return row;

	}

	public ImUser updateProfile(String userId, String nickName, String city, String province, String name, String sign,
			String sex, String district) throws IOException {
		ImUser user = this.getImUser(Long.parseLong(userId));
		if (user != null) {
			if (!StringUtils.isBlank(nickName)) {
				user.setNickName(nickName);
				user.setName(nickName);
				feedService.updateFeed(user.getId(), nickName, "");
			}
			if (!StringUtils.isBlank(district)) {
				user.setDistrict(district);
			}
			if (!StringUtils.isBlank(city)) {
				user.setCity(city);
			}
			if (!StringUtils.isBlank(province)) {
				user.setProvince(province);
			}
			if (!StringUtils.isBlank(name)) {
				user.setName(name);
				user.setNickName(name);
				feedService.updateFeed(user.getId(), name, "");
			}
			if (!StringUtils.isBlank(sex)) {
				user.setSex(sex);
			}
			if (!StringUtils.isBlank(sign)) {
				user.setSign(sign);
			}
			update(user);
			cacheUser(user);
		}
		// 通知好友
		List<ImFriend> friends = getFriends(user.getId());
		
		for (ImFriend friend : friends) {
			readyService.cacheFriendInfo(friend.getFriendId());
			ImMessage msg = msgFactory.userModifyProfileNotice(user.getId(), friend.getFriendId(), user);
			chatService.storeMsgAndNotifyImServer(msg, friend.getFriendId());
		}

		return user;
	}

	public int requestFriend(int destType, long userId, long destId) throws IOException {
		// 如果 是人，
		if (destType == 1) {
			// 查询目标用户
			ImUser destUser = (ImUser) this.queryForObject("from ImUser where id=? ", destId);
			if (destUser == null) {
				return -1;
			}
			if (destUser.getNeedAuth() == 0) {
				RedisUtil.sadd(("friends_"+userId).getBytes(), Longs.toByteArray(destId));
				RedisUtil.sadd(("friends_"+destId).getBytes(), Longs.toByteArray(userId));
				// 对方不需要认证时，直接加双方为好友
				addFriend(userId, destId, true);
				ImMessage msg = msgFactory.friendNotice(userId, destId);
				chatService.storeMsgAndNotifyImServer(msg, destId);
				// 自动为好友
				return 2;
			} else {
				addFriend(userId, destId, false);

				ImMessage msg = msgFactory.friendReqNotice(userId, destId);
				chatService.storeMsgAndNotifyImServer(msg, destId);

				// 已发送等待对方同意
				return 1;
			}
		}
		return -1;

	}
	
	public int checkIdNo(long userId,String idNo)throws IOException{
		HashMap<String, Object> user=(HashMap<String, Object>) this.queryForObjectBySql("select * from im_user where idNo=? limit 1", idNo);
		if (user!=null) {
			if (Long.parseLong(user.get("id").toString())!=userId) {
				return 2;//  已经被使用了
			}else{
				return Integer.parseInt(user.get("isAuth").toString());
			}
		}
		return -1;//  未被占用
	}
	
	/**
	 * 导入手机通讯录
	 * @param userId
	 * @param phone
	 * @return
	 * @throws IOException
	 */
	public int importContact(long userId,String contact)throws IOException{
		contact=StringEscapeUtils.unescapeJava(StringEscapeUtils.unescapeJava(contact));
		contact.replaceAll("\\n", "");
		contact.replaceAll("\\\"", "\"");
		JSONArray json=JSONArray.parseArray(contact);
		int row=0;
		if (json==null) {
			return row;
		}
		this.updateBySql("delete from im_user_contact where userId=?", userId);
//		String phones="";
//		for(int i=0;i<json.size();i++){
//            JSONObject user=json.getJSONObject(i);
//            if (i==(json.size()-1)) {
//            	phones+=user.getString("phone");
//			}else {
//				phones+=user.getString("phone")+",";
//			}
//        }
//		// 取出已经导入联系人不进行重复导入
//		List listp= this.queryForObjListBySql("select phone from im_user_contact where userId=? and phone in (?)", userId,phones);
//		List exists=new ArrayList<>();
//		for (Object ob : listp) {
//			HashMap<String, Object> oContact=(HashMap<String, Object>) ob;
//			exists.add(oContact.get("phone"));
//		}
		List list=new ArrayList<>();
		for(int i=0;i<json.size();i++){
			JSONObject user=json.getJSONObject(i);
//			if (exists.contains(user.getString("phone"))) {
//				continue;
//			}
			ImUserContact uc = new ImUserContact();
            uc.setUserId(userId);
            uc.setHeader(user.getString("header"));
            uc.setMarkName(user.getString("markName"));
            uc.setPhone(user.getString("phone"));
            list.add(uc);
            row++;
        }
		if (list.size()>0) {
			this.saveAll(list);
		}
		return row;
		
	}
	
	public List myContact(long userId)throws IOException{
//		List list=this.queryForObjListBySql("select ucv.phone,ucv.header,ucv.markName,ucv.isExists,u.nickName from im_user_contact_view ucv left join im_user u on u.id=ucv.fuserId where userId=?", userId);
		List list=this.queryForObjListBySql("SELECT uc.userId AS userId,uc.phone AS phone,uc.header AS header,uc.markName AS markName,IF(IFNULL(u.id,0)=0,0,1) AS isExists,u.id AS fuserId,u.nickName from `im_user_contact` uc LEFT JOIN im_user u on `u`.`mobile` like concat('%',`uc`.`phone`,'%') where uc.phone <>'' and uc.phone is not NULL and uc.userId=?", userId);
		return list;
	}
	
	public Page getContacts(long userId,String contact, int pageNo)throws IOException{
		List countrylist=ImConstants.countryCode;
		contact=StringEscapeUtils.unescapeJava(StringEscapeUtils.unescapeJava(contact));
		contact.replaceAll("\\n", "");
		contact.replaceAll("\\\"", "\"");
		JSONArray json=JSONArray.parseArray((String)contact);
		String map="";
		for(int i=0;i<json.size();i++){
			JSONObject user=json.getJSONObject(i);
			String phone=user.getString("phone");
			map+=phone+",";
			for (int j = 0; j < countrylist.size(); j++) {
				map+=countrylist.get(j).toString()+phone+",";
			}
        }
		Page page=new Page();
		page.setPageNo(pageNo);
		page= this.queryForListBySql("select id userId,headUrl,nickName,(select IFNULL((select count(*) from im_friend f where (f.userId=? and f.friendId=t2.id)  HAVING count(*)=1),0)) as isFriend from im_user t2 where exists(select 1 from im_user t1 where INSTR(?,t2.mobile)>0)",page,userId,map);
//		HashMap<String, Object> data=new HashMap<>();
//		List list=page.getList();
//		for (Object ob:list) {
////			ob.se
//			for(int i=0;i<json.size();i++){
//				JSONObject user=json.getJSONObject(i);
//				String phone=user.getString("phone");
//				
//	        }
//		}
		return page;	
	}
	
	public ImUserReport report(long userId,long destId,int destType,String imgs,String msg){
		ImUserReport report=new ImUserReport();
		report.setUserId(userId);
		report.setDestId(destId);
		report.setDestType(destType);
		report.setReportImgs(imgs);
		report.setReportText(msg);
		this.save(report);
		return report;
	}

	public HashMap<String, Object> registDoc(String key){
		HashMap<String, Object> documet=(HashMap<String, Object>) this.queryForObjectBySql("select content,title from im_document where _key =?",key);
		return documet;
		
	}
	
	/**
	 * 获取我拉黑的好友和拉黑我的好友ids
	 * 和我不可以看 还有我 不看的好友ids
	 * @param userId
	 * @return
	 */
	public Set<Long> getUserBlackList(long userId){
		List<Long> list=this.createQuery("select friendId from ImFriend where userId="+userId+" and isFriend=1 and isBlack=1").list();
		List<Long>  fList=this.createQuery("select userId from ImFriend where friendId="+userId+" and isFriend=1 and isBlack=1").list();
		List<BigInteger> feedlist=this.createSQLQuery("select userId from im_friend where friendId="+userId+" and isFriend=1 and ufeedPriv=0").list();
		List<BigInteger> ufeedlist=this.createSQLQuery("select friendId from im_friend where userId="+userId+" and isFriend=1 and feedPriv=0").list();
		Set<Long> data =new HashSet<>();
		for (Long uid : list) {
			data.add(uid);
		}
		for (Long uid : fList) {
			data.add(uid);
		}
		for (BigInteger uid : feedlist) {
			data.add(Long.parseLong(uid.toString()));
		}
		for (BigInteger uid : ufeedlist) {
			data.add(Long.parseLong(uid.toString()));
		}
		return data;
	}
	
	public Set<Long> getFeedExcept(long userId){
		List<BigInteger> list=this.createQuery("select friendId from ImFriend where userId="+userId+" and isFriend=1 and isBlack=1").list();
		List<BigInteger>  fList=this.createQuery("select userId from ImFriend where friendId="+userId+" and isFriend=1 and isBlack=1").list();
		// 朋友圈设置了不给好友看的
		List<BigInteger> ufeedlist=this.createSQLQuery("select friendId from im_friend where userId="+userId+" and isFriend=1 and isBlack=0 and ufeedPriv=0").list();
		// 朋友圈设置了不给我看的
		List<BigInteger> feedlist=this.createSQLQuery("select userId from im_friend where friendId="+userId+" and isFriend=1 and isBlack=0 and feedPriv=0").list();
		Set<Long> data =new HashSet<>();
		if (list!=null) {
			for (BigInteger uid : list) {
				data.add(Long.parseLong(uid.toString()));
			}
		}
		if (fList!=null) {
			for (BigInteger uid : fList) {
				data.add(Long.parseLong(uid.toString()));
			}
		}
		if (ufeedlist!=null) {
			for (BigInteger uid : ufeedlist) {
				data.add(Long.parseLong(uid.toString()));
			}
		}
		if (feedlist!=null) {
			for (BigInteger uid : feedlist) {
				data.add(Long.parseLong(uid.toString()));
			}
		}
		return data;
	}
	/**
	 * 创建用户
	 * @return
	 */
	public ImUser createUser(ImUser user){
		
		try {
			this.save(user);
			this.cacheUser(user);
			//测试使用
			this.initBalance(user.getId());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
		
	}
	
	/**
	 * 保存摇一摇历史记录
	 */
	public void saveRockRecord(Long userId,Long destId,double distance){
		try {
			ImUser destUser = this.getImUser(destId);
			if (destUser!=null) {
				ImRockRecord record=new ImRockRecord();
				record.setUserId(userId);
				record.setDestId(destId);
				record.setName(destUser.getName());
				record.setHeadUrl(destUser.getHeadUrl());
				record.setSex(destUser.getSex());
				record.setSign(destUser.getSign());
				record.setIsdelete(0);
				record.setDistance(distance);
				this.save(record);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Page getRockRecord(Long userId,int pageNo){
		Page page= new Page();
		page.setPageNo(pageNo);
		page = this.queryForListBySql("select id as rockid,destId as userId,headUrl,name as nickName,sex,distance,sign from im_rock_record where userId=? and isdelete=0 order by id desc", page,userId);
		return page;
	}
	
	public int removeRockRecord(Long userId,Long id){
		if (id>0) {
			return this.update("update ImRockRecord set isdelete=1 where userId=? and id=?", userId,id);
		}
		return this.update("update ImRockRecord set isdelete=1 where userId=?", userId);
	}
	
	public int saveRockMesssage(Long userId,Long destId,Long pid,String msg) throws IOException{
		int row=0;
		ImRockMessage message=new ImRockMessage();
		message.setUserId(destId);
		message.setDestId(userId);
		message.setMsg(msg);
		message.setPid(pid);
		message.setAddTime(System.currentTimeMillis());
		this.save(message);
		row=1;
		ImMessage notice=msgFactory.sayHelloNotice(userId, destId, pid, msg);
		chatService.storeMsgAndNotifyImServer(notice, destId);
		return row;
	}
	
	public Page getRockMessage(Long userId,int pageNo){
		Page page= new Page();
		page.setPageNo(pageNo);
		List<HashMap<String, Object>> list=this.queryForObjListBySql("select u.headUrl,g.id gid,u.name as nickName,g.destId userId,g.msg,g.addTime from im_rock_message g left join im_user u on u.id=g.destId where g.pid=0 and g.userId=? order by g.addTime desc limit ?,?", userId,(page.getPageNo()-1)*page.getPageSize(),page.getPageSize());
		if (list!=null) {
			for (HashMap<String, Object> message : list) {
				List<HashMap<String, Object>> cList=this.queryForObjListBySql("select u.name as nickName,g.id as msgid,g.msg from im_rock_message g left join im_user u on u.id=g.destId where g.pid=?", message.get("gid"));
				message.put("clist", cList);
			}
		}
		page.setList(list);
		return page;
	}
	
	public int removeRockMessage(Long userId,Long id){
		int row=0;
		if (id>0) {
			row+=this.update("delete from ImRockMessage where userId=? and (id=? or pid=?)",userId, id, id);
		}else{
			row=this.updateBySql("delete from im_rock_message where userId=? and (id in (select a.id from (select id from im_rock_message where userId=?) a) or pid in (select b.id from (select id from im_rock_message where userId=?) b))",userId,userId,userId);
//			List<HashMap<String, Object>> list = this.queryForObjListBySql("select * from im_rock_message where userId=?", userId);
//			if (list!=null) {
//				for (HashMap<String, Object> item : list) {
//					this.update("delete from ImRockMessage where id=? or pid=?", item.get("id"));
//					row++;
//				}
//			}
		}
		return row;
	}
	
}
