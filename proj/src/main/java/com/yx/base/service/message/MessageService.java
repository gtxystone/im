package com.yx.base.service.message;

import java.util.List;

import org.springframework.stereotype.Service;

import com.framework.service.EntityServiceImpl;

@SuppressWarnings("rawtypes")
@Service
public class MessageService extends EntityServiceImpl {

	public List getHistory(long destId, long destType, int size, long sendTime, long userId) {
		if(sendTime>0)
		return queryForObjListBySql("select * from im_message_view where belongId=? and sendTime<? and fromType=? order by id desc limit 0,?",
				userId, sendTime, destType, size);
		else{
			return queryForObjListBySql("select * from im_message_view where belongId=? and fromType=? order by id desc limit 0,?",
					userId, destType, size);
		}
	}
}
