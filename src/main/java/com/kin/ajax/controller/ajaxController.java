package com.kin.ajax.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ajaxController {

	@RequestMapping(value = "/ajax/ajaxMain.do")
	public String ajaxMain() {
		
		log.info("--/ajax/ajaxMain.do");
		
		return "ajax/ajaxMain";
	}
	
}
