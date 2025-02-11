package com.kin.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class logoutController {

	@RequestMapping(value="/logout/logout.do")
	public String question() {
		
		System.out.println("--/logout/logout in");
		
		return "/logout/logout";
	}
	
}
