package com.yx.base.controller.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.sql.ast.expr.SQLSequenceExpr.Function;
import com.framework.model.Page;
import com.framework.util.RedisUtil;
import com.google.common.base.Joiner;
import com.google.common.primitives.Longs;
import com.opslab.util.RandomUtil;
import com.yx.base.parameter.ResponseData;
import com.yx.base.service.user.UserService;
import com.yx.base.util.YxUtil;

import redis.clients.jedis.GeoRadiusResponse;
import redis.clients.jedis.GeoUnit;

@RequestMapping("/geo")
@Controller
public class NearbyController {
	
	@Autowired
	private UserService userService;

	/**
	 * 更新客户端的位置信息
	 * @param userId
	 * @param lon 经度
	 * @param lat 纬度
	 */
	@RequestMapping("/updateGeo")
	@ResponseBody
	public ResponseData updateGeo(long userId,double longitude,double latitude){
		RedisUtil.geoadd("user_geo".getBytes(), longitude, latitude, Longs.toByteArray(userId));
		userService.updateBySql("update im_user set longitude=?,latitude=? where id=?", longitude,latitude,userId);
		return YxUtil.createSimpleSuccess("update finished.");
	}
	
	/**
	 * 摇一摇
	 * @param userId
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/findRandom")
	@ResponseBody
	public ResponseData findRandom(long userId,double longitude,double latitude) throws IOException{		
		
		byte[] yaoKey="user_geo_yy".getBytes();
		RedisUtil.expired(yaoKey, 10);
		List<GeoRadiusResponse> list=RedisUtil.georadius(yaoKey, longitude, latitude, 9000d, GeoUnit.KM);
		
		RedisUtil.geoadd(yaoKey, longitude, latitude, Longs.toByteArray(userId));		
		if(list==null||list.size()==0){
			return YxUtil.getResponse(0, "没有找到同一时刻的人");
		}else{
			
			int index=0;
			if(list.size()>1){
				index=RandomUtil.integer(0, list.size()-1);
			}
			GeoRadiusResponse el=list.get(index);
			if(list.size()==1&&Longs.fromByteArray(el.getMember())==userId){
				return YxUtil.getResponse(0, "没有找到同一时刻的人");				
			}
			if(list.size()>1&&Longs.fromByteArray(el.getMember())==userId){
				if(index==0){
					index=list.size()-1;
				}else{
					index=0;
				}
				el=list.get(index);
			}
			
			Double distance=RedisUtil.geodist(yaoKey, Longs.toByteArray(userId), el.getMember(), GeoUnit.M);
			Object member=userService.queryForObjectBySql("select id,name,sex,headUrl,sign from im_user where id=?", Longs.fromByteArray(el.getMember()));
			HashMap<String,Object> map=new HashMap<String,Object>();
			map.put("distance", distance);
			map.put("user", member);
			userService.saveRockRecord(userId, Longs.fromByteArray(el.getMember()), distance);
			return YxUtil.createSuccessData(map);
		}
		
	}
	
	/**
	 * 查询摇一摇历史记录
	 */
	@RequestMapping("/getRockRecord")
	@ResponseBody
	public ResponseData getRockRecord(long userId,@RequestParam(defaultValue="1")int page){
		return YxUtil.createSuccessData(userService.getRockRecord(userId, page));
	}
	
	/**
	 * 清除摇一摇历史记录
	 */
	@RequestMapping("/removeRockRecord")
	@ResponseBody
	public ResponseData removeRockRecord(Long userId,@RequestParam(defaultValue="0") Long id){
		if (userService.removeRockRecord(userId,id)>=0) {
			return YxUtil.createSimpleSuccess("清除成功");
		}else{
			return YxUtil.createFail("网络繁忙，请稍后重试");
		}
		
	}
	
	/**
	 * 打招呼或者回复
	 * @throws IOException 
	 */
	@RequestMapping("/sendGreet")
	@ResponseBody
	public ResponseData sayHello(Long userId,Long destId,@RequestParam(defaultValue="0")Long pid,@RequestParam(defaultValue="向你打了一声招呼")String msg) throws IOException{
		if (userService.saveRockMesssage(userId, destId, pid, msg)>=0) {
			return YxUtil.createSimpleSuccess("发送成功");
		}else{
			return YxUtil.createFail("网络繁忙，请稍后重试");
		}
	}
	
	/**
	 * 打招呼的人
	 */
	@RequestMapping("/greetList")
	@ResponseBody
	public ResponseData greetList(Long userId,@RequestParam(defaultValue="1")Integer pageNo) throws IOException{
		return YxUtil.createSuccessData(userService.getRockMessage(userId, pageNo));
	}
	
	/**
	 * 清除打招呼的人
	 */
	@RequestMapping("/removeRockMessage")
	@ResponseBody
	public ResponseData removeRockMessage(Long userId,@RequestParam(defaultValue="0") Long id){
		if (userService.removeRockMessage(userId,id)>=0) {
			return YxUtil.createSimpleSuccess("清除成功");
		}else{
			return YxUtil.createFail("网络繁忙，请稍后重试");
		}
		
	}
	
	
	
	/**
	 * 附近的人
	 * @param userId
	 * @param lon
	 * @param lat
	 * @return
	 */
	@RequestMapping("/findNearby")
	@ResponseBody
	public ResponseData findNearby(long userId,double longitude,double latitude,@RequestParam(defaultValue="1")int pageNo,@RequestParam(defaultValue="")String sex){
		List<GeoRadiusResponse> memList=RedisUtil.georadius("user_geo".getBytes(), longitude, latitude, 100d, GeoUnit.KM);
		List<Long> memberIds=new ArrayList<Long>();
		for(GeoRadiusResponse m:memList){
			memberIds.add(Longs.fromByteArray(m.getMember()));
		}
		String idStr=Joiner.on(",").join(memberIds);
		if(StringUtils.isBlank(idStr)){
			idStr=""+userId;
		}
		String sexStr="and sex =\""+sex+"\"";
		if (StringUtils.isBlank(sex)) {
			sexStr="and 1=1";
		}
		if (StringUtils.equals(sex, "女")) {
			sexStr="and (sex =\""+sex+"\" or sex is null)";
		}
		Page page=new Page();
		page.setPageNo(pageNo);
		page=userService.queryForListBySql("select id,name,sex,longitude,latitude,sign,headUrl from im_user where id in("+idStr+") and id<>? "+sexStr, page,userId);
		userService.updateBySql("update im_user set longitude=?,latitude=? where id=?", longitude,latitude,userId);
		return YxUtil.createSuccessData(page);
	}
	
	public static void main(String args[]){
		List<Long> memberIds=new ArrayList<Long>();
		memberIds.add(11l);
		memberIds.add(12l);
		memberIds.add(13l);
		memberIds.add(14l);
		String idStr=Joiner.on(",").join(memberIds);
		System.out.println(idStr);
		
		System.out.println(RandomUtil.integer(0, 12));
	}
}
