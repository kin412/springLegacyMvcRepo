package com.kin.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	//getParameterMap으로 모든 파라미터 읽기
	@ResponseBody
	@RequestMapping(value = "/getParameterMap.do")
	public String getParameterMap(HttpServletRequest request, @RequestParam String conChk_text3) {
		//Map<String, Object>
		System.out.println("getParameterMap start");
		//System.out.println("----request : " + request.getParameter("conChk_text2"));
		
		System.out.println("---- @RequestParam conChk_text3 : " + conChk_text3);
		
		Map<String, String[]> paramMap = new HashMap<String, String[]>();
		paramMap = request.getParameterMap();
		
		System.out.println("--------getClass : " + request.getParameterMap().get("conChk_text2").getClass());
		
		//체크박스 같은 경우 같은 key에 여러 value가 저장될수 있기때문에 value는 배열형태로 오는듯?
		System.out.println("----paramMap.get(\"conChk_text2\")[0] : " + paramMap.get("conChk_text2")[0]);
		System.out.println("----paramMap.get(\"conChk_text2\").length : " + paramMap.get("conChk_text2").length);
		
		for (Map.Entry<String, String[]> entry : paramMap.entrySet())
		{
		    System.out.println("----key : " + entry.getKey() + " / " + "value : " + entry.getValue()[0]);
		}

		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("t1", "t");
		map.put("t2", "tt");
		map.put("t3", "ttt");
		
		System.out.println("getParameterMap end");
		return "return getParameterMap"; //dataType : "html"
	}
	
	//json
	@ResponseBody
	@RequestMapping(value = "/jsonChk.do")
	public Map<String, Object> jsonChk(HttpServletRequest request, @RequestParam String conChk_text4
			,@ModelAttribute homeVo param) {
		//Map<String, Object>
		System.out.println("jsonChk start");
		System.out.println("---- @RequestParam conChk_text4 : " + conChk_text4);
		System.out.println("----homeVo param.toString : " + param.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("t1", "t");
		map.put("t2", "tt");
		map.put("t3", "ttt");
		
		System.out.println("jsonChk end");
		return map; //dataType : "json"
	}
	
}
