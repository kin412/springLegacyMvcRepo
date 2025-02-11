package com.kin.securityHandler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class custumAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException exception)
			throws IOException, ServletException {
		System.out.println("--custumAccessDeniedHandler handle in , redirect");
		System.out.println("--request.getContextPath() : " + request.getContextPath());
		
		System.out.println("--exception.getMessage() : " + exception.getMessage());
		
		response.sendRedirect(request.getContextPath()+"/error/accessError.do");
		
	}

}
