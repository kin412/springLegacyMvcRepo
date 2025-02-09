package com.kin.main.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kin.main.service.mainService;
import com.kin.main.service.mainVo;

@Controller
public class mainController {
	
	@Autowired
	private mainService mainService;

	@RequestMapping(value = "/main/main.do")
	public String main() {
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
		
		return mainService.searchPg(mainVo);
	}
	
}
