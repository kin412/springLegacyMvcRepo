package com.kin.menu.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kin.menu.service.menuService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class menuController {
	
	@Autowired
	private menuService menuService;

	@ResponseBody
	@RequestMapping(value = "/menu/menuList.do")
	public Map<String, Object> menuList() {
		log.info("--/menu/menuList.do");
		
		return menuService.menuList();
	}
	
	
}
