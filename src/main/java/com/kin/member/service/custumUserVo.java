package com.kin.member.service;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class custumUserVo extends User {

	private static final long serialVersionUID = 1L;
	
    private memberVo memberVo;
    
    public custumUserVo(String userid, String userpw, Collection<? extends GrantedAuthority> authorities) {
        super(userid, userpw, authorities);
    }
    
    public custumUserVo(memberVo vo) {
    	super(vo.getUserid(), vo.getUserpw(), vo.getAuthlist().stream()
    			.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList())
    			);
    	
    	this.memberVo = vo;
    }
	
}
