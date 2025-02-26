package com.kin.menu.service.impl;

import java.util.List;

import com.kin.member.service.authVo;
import com.kin.menu.service.menuVo;

public interface menuMapper {
	
	public List<menuVo> menuList(authVo authVo);
}
