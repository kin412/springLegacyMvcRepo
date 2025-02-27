package com.kin.securityHandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class custumLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		
		System.out.println("--successHandler in");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority ->{
		
			roleNames.add(authority.getAuthority());
			
		});
		
		if(roleNames.contains("ROLE_ADMIN")) {
			log.info("-- 성공 핸들러 role_admin");
			response.sendRedirect(request.getContextPath()+"/main/main.do?p=1");
			return;
		}
		
		if(roleNames.contains("ROLE_USER")) {
			log.info("-- 성공 핸들러 role_user");
			response.sendRedirect(request.getContextPath()+"/main/main.do?p=1");
			return;
		}
		
		log.info("--failed");
		
		response.sendRedirect(request.getContextPath()+"/login/login.do");
		
	}

}
