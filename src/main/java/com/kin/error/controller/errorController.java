package com.kin.error.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class errorController {

	@RequestMapping(value = "/error/accessError.do")
	public String accessError(HttpServletRequest request, Authentication auth) {
		
		
		log.info("--/error/accessError.do");
		log.info("--auth : " + auth);
		log.info("--_csrf : " + request.getParameter("_csrf"));
		log.info("--id : " + request.getParameter("id"));
		log.info("--pw : " + request.getParameter("pw"));
		
		return "error/accessError";
	}
	
	@RequestMapping(value = "/error/exceptionError.do")
	public String exceptionError(HttpServletRequest request) {
		
		log.info("--/error/exceptionError.do");
		
		return "error/exceptionError";
	}
	
}
