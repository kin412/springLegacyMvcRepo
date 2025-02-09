package com.kin.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kin.comm.service.pagingVo;
import com.kin.main.service.mainService;
import com.kin.main.service.mainVo;

@Service
public class mainServiceImpl implements mainService {

	@Autowired
	private mainMapper mapper;

	@Override
	public List<mainVo> search(mainVo mainVo) {
		
		return mapper.search(mainVo);
	}

	@Override
	public Map<String, Object> searchPg(mainVo mainVo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		pagingVo pagingVo = new pagingVo();
		
		int totalCnt = mapper.totalCnt(mainVo);
		//페이징
		pagingVo.setCurrentPage(mainVo.getCurrentPage());
		pagingVo.setPageSize(mainVo.getPageSize());
		pagingVo.setPaging(totalCnt);
		
		mainVo.setCurrentPage(pagingVo.getCurrentPage());
		mainVo.setPageSize(pagingVo.getPageSize());
		
		List boardList = mapper.search(mainVo);
		
		map.put("boardList", boardList);
		map.put("totalCnt", totalCnt);
		map.put("pagingVo", pagingVo);
		
		return map;
	}
	
	

}
