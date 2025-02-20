package com.kin.adminFileTest.service.impl;

import java.util.List;

import com.kin.adminFileTest.service.adminFileTestVo;

public interface adminFileTestMapper {
	
	public List<adminFileTestVo> adminFileTestList();
	public int InsertadminFileTest(adminFileTestVo adminFileTestVo);
	public int maxSeq();
}
