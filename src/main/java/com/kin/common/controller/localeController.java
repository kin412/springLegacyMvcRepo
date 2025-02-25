package com.kin.common.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class localeController {

	//locale을 세션에 저장하는 경우. 이외에도 인터셉터에 적용해도됨.
	@ResponseBody
	@RequestMapping(value = "/locale/chageLang.do")
	public void chageLang(HttpServletRequest request, @RequestParam("localeLang") String localeLang) {
		
		/*
		var localeLang = $("#localeLang option:selected").val();
		data:localeLang,
		화면단 ajax에서 이렇게만 달랑 보내면 
		paramName : en || pramValue : 
		이런식으로 paramName만 감. value가 없음.
		
		Enumeration<String> paramNames = request.getParameterNames();
	       
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            log.info("--paramName : " + paramName + " || pramValue : " + request.getParameter(paramName));
        }
        
        */
		
		
		log.info("-- localeLang : " + localeLang);
		
		HttpSession session = request.getSession();
		Locale locale = new Locale(localeLang);
		
		session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, locale);
		
		
	}
	
}
