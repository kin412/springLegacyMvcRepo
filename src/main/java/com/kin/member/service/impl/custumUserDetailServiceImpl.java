package com.kin.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.kin.member.service.custumUserVo;
import com.kin.member.service.memberVo;

import lombok.Setter;

public class custumUserDetailServiceImpl implements UserDetailsService{

	//@autowired와 거의 비슷한거 같은데 test환경에서 쓰임새가 달라지는 모양인듯? 
	@Setter(onMethod_ = @Autowired)
	private memberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		memberVo memberVo = memberMapper.read(userid);
		return memberVo == null ? null : new custumUserVo(memberVo);
	}

}
