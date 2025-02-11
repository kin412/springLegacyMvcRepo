package com.kin.login.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class loginController {
	
	@RequestMapping(value = "/login/login.do")
	public String login() {
		System.out.println("-- /login/login.do");
		
		return "login/login";
	}
	
}
