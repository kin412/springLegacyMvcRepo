package com.kin.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
