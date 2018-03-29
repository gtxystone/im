package com.yx.base.service.bank;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.framework.service.EntityServiceImpl;
import com.yx.base.extendmodel.ImUserBankcard;

@SuppressWarnings("rawtypes")
@Service
public class BankService extends EntityServiceImpl {
	
	@Autowired
	private MongoTemplate mongoTemplate;
	
	@SuppressWarnings("unchecked")
	@Transactional
	public List<ImUserBankcard> getCardList(long userId) throws IOException{
		List<ImUserBankcard> list=this.find("from ImUserBankcard where userId=?", userId);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	@Transactional
	public ImUserBankcard bandingCard(long userId,String cardNo,String bankName){
		ImUserBankcard bankcard = new ImUserBankcard();
		bankcard.setUserId(userId);
		bankcard.setCardNo(cardNo);
		bankcard.setBankName(bankName);
		save(bankcard);
		return bankcard;
	}
	
	@Transactional
	public int dissCard(long userId,long cardId)throws IOException{
		return this.update("delete from ImUserBankcard where userId=? and id=?", userId,cardId);
	}

}
