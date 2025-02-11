package com.kin.securityHandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

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
			System.out.println("-- 성공 핸들러 role_admin");
			response.sendRedirect(request.getContextPath()+"/main/main.do");
			return;
		}
		
		if(roleNames.contains("ROLE_USER")) {
			System.out.println("-- 성공 핸들러 role_user");
			response.sendRedirect(request.getContextPath()+"/main/main.do");
			return;
		}
		
		System.out.println("--성공 핸들러 여기오면 안됨");
		
		response.sendRedirect(request.getContextPath()+"/login/login.do");
		
	}

}
