package com.kin.adminFileTest.service;

import java.util.List;

public interface adminFileTestService {

	public List<adminFileTestVo> adminFileTestList();
	public int InsertadminFileTest(adminFileTestVo adminFileTestVo);
	public int maxSeq();
}
