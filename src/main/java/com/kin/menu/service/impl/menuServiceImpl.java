package com.kin.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.kin.member.service.authVo;
import com.kin.member.service.custumUserVo;
import com.kin.member.service.memberVo;
import com.kin.menu.service.menuService;
import com.kin.menu.service.menuVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class menuServiceImpl implements menuService {

	@Autowired
	private menuMapper mapper;

	@Override
	public Map<String, Object> menuList() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		authVo authVo = new authVo();
		authVo.setAuth("ROLE_USER");
		
		//시큐리티 로그인 정보 객체
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//권한 - 형변환 할 수 없음
		//System.out.println("--getAuthorities : " + authentication.getAuthorities());
		//사용자 객체
		//System.out.println("-- principal : " + authentication.getPrincipal().toString());
		
		//List authList = (List) authentication.getAuthorities();
		
		custumUserVo custumUserVo = (custumUserVo)authentication.getPrincipal();
		memberVo memberVo = custumUserVo.getMemberVo();
		List<authVo> authVoList = memberVo.getAuthlist();
		String auth = "";
		
		//관리자 권한 있는지 체크
		for(int i=0; i<authVoList.size(); i++) {
			auth = authVoList.get(i).getAuth();
			if(auth.equals("ROLE_ADMIN")) {
				authVo.setAuth(auth);
			}
		}
		
		List<menuVo> menuList = mapper.menuList(authVo);
		
		map.put("menuList", menuList);
		
		return map;
	}

}
