package com.kin.app;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class testFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 필터 초기화 코드
		//Filter.super.init(filterConfig);
		// import jakarta.servlet.*; ??
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 필터 동작 코드 (전처리)
        System.out.println("Request received at " + System.currentTimeMillis());

        // 다음 필터로 체인 전달 또는 실제 서블릿 호출
        chain.doFilter(request, response);

        // 필터 동작 코드 (후처리)
        System.out.println("Response sent at " + System.currentTimeMillis());
		
	}
	
	@Override
	public void destroy() {
		// 필터 소멸 코드
		//Filter.super.destroy();
	}

}
