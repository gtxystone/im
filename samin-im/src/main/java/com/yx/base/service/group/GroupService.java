package com.yx.base.service.group;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;


@SuppressWarnings({"rawtypes","unchecked"})
@Service
public class GroupService{
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public List<Map<String, Object>> getAllMemberFromCache(long groupId) throws IOException{
		List list=jdbc.queryForList("select a.userId,IFNULL(a.markName,b.name) name,b.id,b.headUrl,b.province,b.city,b.district,b.sign from im_group_member a LEFT JOIN im_user b on(a.userId=b.id) where groupId=? and isAccept=1 group by userId ORDER BY rand()", groupId);

		return list;
	}		
}
