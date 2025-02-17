package com.kin.login.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kin.login.service.loginService;
import com.kin.member.service.memberVo;

@Service
public class loginServiceImpl implements loginService {

	@Autowired
	private loginMapper mapper;

	@Override
	public int idCheck(String userid) {
		
		int checkFg = mapper.idCheck(userid);
		
		//checkFg = Integer.toString(idCheckList.size());
		
		System.out.println("--checkFg : " + checkFg);
		
		return checkFg;
	}

	@Override
	public Map<String, Object> joinMemberShip(memberVo memberVo) {
		Map map = new HashMap<String, Object>();
		
		//member table
		int result = mapper.insertMember(memberVo);
		
		//member_auth table
		int auth_result = mapper.insertAuth(memberVo);
		
		map.put("message", "회원가입이 완료되었습니다");	
		map.put("result", result);	
		map.put("auth_result", auth_result);	
		
		return map;
	}
	
	
	
}
