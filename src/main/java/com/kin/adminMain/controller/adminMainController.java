package com.kin.adminMain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class adminMainController {

	@RequestMapping(value = "/adminMain/adminMain.do")
	public String adminMain() {
		
		return "adminMain/adminMain";
	}
	
	
	
}
