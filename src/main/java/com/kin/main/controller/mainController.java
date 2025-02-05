package com.kin.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class mainController {

	@RequestMapping(value = "/main/main.do")
	public String main() {
		
		return "main/main";
	}
	
	@RequestMapping(value = "/main/main2.do")
	public String main2() {
		
		return "main/main2";
	}
	
}
