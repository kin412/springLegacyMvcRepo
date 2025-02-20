package com.kin.adminFileTest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kin.adminFileTest.service.adminFileTestService;
import com.kin.adminFileTest.service.adminFileTestVo;

@Service
public class adminFileTestServiceImpl implements adminFileTestService {

	@Autowired
	private adminFileTestMapper mapper;

	@Override
	public List<adminFileTestVo> adminFileTestList() {
		
		return mapper.adminFileTestList();
	}

	@Override
	public int InsertadminFileTest(adminFileTestVo adminFileTestVo) {
		
		return mapper.InsertadminFileTest(adminFileTestVo);
	}

	@Override
	public int maxSeq() {
		
		return mapper.maxSeq();
	}
	

}
