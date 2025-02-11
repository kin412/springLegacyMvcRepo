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
	public String login(HttpServletRequest request, Authentication auth) {
		
		
		System.out.println("--/error/accessError.do");
		System.out.println("--auth : " + auth);
		System.out.println("--_csrf : " + request.getParameter("_csrf"));
		System.out.println("--id : " + request.getParameter("id"));
		System.out.println("--pw : " + request.getParameter("pw"));
		
		return "error/accessError";
	}
	
}
