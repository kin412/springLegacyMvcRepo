package com.kin.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class exIntercepter extends HandlerInterceptorAdapter{

	//인터셉터에 적용해서 현재 실행중인 클래스명과 메서드명을 log로 찍어보기
	
	//전처리기는 클라이언트에서 컨트롤러로 요청할 때 가로채는 것이다. 쉽게 말해 컨트롤러가 호출되기 전에 실행되는 메서드이다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		//log.info("--postHandle request.getRequestURI() : " + request.getRequestURI());
		log.info("request.getServletPath() : " + request.getServletPath());
		//log.info("--request.getParameterMap().size() : " +request.getParameterMap().size());
		//log.info("--modelAndView Name : " + modelAndView.getViewName());
		
		/*
        Enumeration<String> paramNames = request.getParameterNames();
       
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            log.info("--paramName : " + paramName + " || pramValue : " + request.getParameter(paramName));
        }
        */
		
		super.postHandle(request, response, handler, modelAndView);
	}

	//후처리기는 컨트롤러에서 클라이언트로 요청할 때 가로채는 것이다. 쉽게 말해 컨트롤러가 호출되고 난 후에 실행되는 메서드이다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//log.info("--preHandle");
		
		
		return super.preHandle(request, response, handler);
	}

	//컨트롤러의 처리가 끝나고 화면처리까지 모두 끝나면 실행되는 메서드이다.
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		//log.info("--afterCompletion");
		
		super.afterCompletion(request, response, handler, ex);
	}
	
	
}
