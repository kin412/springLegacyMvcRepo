package com.kin.mail.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kin.mail.service.mailService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class mailController {
	
	@Autowired
	private mailService mailService;

	@ResponseBody
	@RequestMapping(value = "/sendMail/sendMail.do")
	public void sendSimpleMail(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		mailService.sendMail("받는 사람 메일주소","메일 제목","메일 내용");
		log.info("메일 전송 완료");
		
	}
	
	
}
