package com.kin.login.service.impl;

import com.kin.member.service.memberVo;

public interface loginMapper {
	
	public int idCheck(String userid);
	public int insertMember(memberVo memberVo);
	public int insertAuth(memberVo memberVo);
}
