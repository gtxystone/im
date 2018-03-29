package com.yx.base.service.friend;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.swing.tree.RowMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.yx.base.model.ImFriend;


@SuppressWarnings({"rawtypes","unchecked"})
@Service
public class FriendService{
	
	@Autowired
	private JdbcTemplate jdbc;
	
	/**
	 * 检测是不是好友   黑名单也不是好友
	 * @param userId
	 * @param destId
	 * @return -1 非好友  0 被拉黑 1 好友状态
	 */
	public int friendCheck(Long userId,Long destId){
		BeanPropertyRowMapper<ImFriend> friend=new BeanPropertyRowMapper<>(ImFriend.class);
		String sql="select * from im_friend where userId=? and friendId=?";
		ImFriend ufriend=jdbc.queryForObject(sql, friend, userId,destId);
		ImFriend dfriend=jdbc.queryForObject(sql, friend, destId,userId);
		if (ufriend!=null&&dfriend!=null) {
			if (dfriend.getIsBlack()==1) {
				return 0;
			}
			return 1;
		}
		return -1;
	}		
}
