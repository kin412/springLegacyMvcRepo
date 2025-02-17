package com.kin.login.service;

import java.util.Map;

import com.kin.member.service.memberVo;

public interface loginService {

	public int idCheck(String userid);
	public Map<String, Object> joinMemberShip(memberVo memberVo);
}
