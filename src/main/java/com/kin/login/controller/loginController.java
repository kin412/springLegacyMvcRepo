package com.kin.login.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kin.login.service.loginService;
import com.kin.member.service.memberVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class loginController {
	
	@Autowired
	private loginService loginService;
	
	@RequestMapping(value = "/login/login.do")
	public String login() {
		System.out.println("-- /login/login.do");
		
		return "login/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/login/idCheck.do")
	public int idCheck(@RequestParam String userid, HttpServletRequest request) {
		System.out.println("-- /login/idCheck.do");
		System.out.println("--userid : " + userid);
		return loginService.idCheck(userid);
	}
	
	@ResponseBody
	@RequestMapping(value = "/login/joinMemberShip.do")
	public Map<String, Object> joinMemberShip(@ModelAttribute memberVo memberVo) {
		System.out.println("-- /login/joinMemberShip.do");
		System.out.println("--memberVo.toString : " + memberVo.toString());
		return loginService.joinMemberShip(memberVo);
	}
	
}
