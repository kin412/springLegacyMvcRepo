package com.kin.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kin.main.service.mainService;
import com.kin.main.service.mainVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class mainController {
	
	//@Slf4j 어노테이션과 역할이 같다
	//private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private mainService mainService;

	/*@Secured, @PreAuthorize @PostAuthorize  - 스프링 시큐리티 어노테이션  xml의 설정대신 사용가능, bean설정도 있음*/
	@RequestMapping(value = "/main/main.do")
	public String main(@ModelAttribute mainVo mainVo, ModelMap modal, HttpServletRequest request) {
		
		System.out.println("--main/main.do");
		
		//log예시
		/*
		log.info("--info");
		log.trace("--trace");
		log.debug("--debug");
		log.warn("--warning");
		log.error("--error");
		*/
		
		/*int currentPage = mainVo.getCurrentPage();
		
		System.out.println("--currentPage : " + currentPage);
		
		if(currentPage == 0) {
			modal.addAttribute("currentPage", 1);
		}else {
			
		}*/
		
		/*
		 * 세션 설정 예시
		HttpSession session = request.getSession();
		session.setAttribute("testInfomation", "testInfomationValue");
		
		System.out.println("session : " + session.getAttribute("testInfomation"));
		*/
		
		return "main/main";
	}
	
	@RequestMapping(value = "/main/main2.do")
	public String main2() {
		
		return "main/main2";
	}
	
	@ResponseBody
	@RequestMapping(value = "/main/search.do")
	public List<mainVo> search(@ModelAttribute mainVo mainVo) {
		
		return mainService.search(mainVo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/main/searchPg.do")
	public Map<String, Object> searchPg(@ModelAttribute mainVo mainVo) {
		System.out.println("--/main/searchPg.do");
		return mainService.searchPg(mainVo);
	}
	
	//수정화면 페이지 전환형 modelMap으로 vo 전달하기
	@RequestMapping(value = "/main/selectDetail.do")
	public String selectDetail(@ModelAttribute mainVo mainVo, ModelMap modal) {
		
		int seq = mainVo.getSeq();
		System.out.println("--seq : " + seq);
		if(seq != 0) {
			//수정
			modal.addAttribute("detail", mainService.selectDetail(seq));
		}else {
			//등록
			mainVo.setSeq(0);
			modal.addAttribute("detail", mainVo);
		}
		
		return "main/selectDetail";
	}
	
	//등록&수정
	@ResponseBody
	@RequestMapping(value = "/main/createAndUpdateDetail.do")
	public Map<String, Object> createAndUpdateDetail(@ModelAttribute mainVo mainVo) {
		
		return mainService.createAndUpdateDetail(mainVo);
	}
	
	//삭제
	@ResponseBody
	@RequestMapping(value = "/main/deleteDetail.do")
	public Map<String, Object> deleteDetail(@ModelAttribute mainVo mainVo) {
		
		return mainService.deleteDetail(mainVo);
	}
	
	
}
