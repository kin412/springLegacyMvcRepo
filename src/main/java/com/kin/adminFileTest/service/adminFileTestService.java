package com.kin.adminFileTest.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface adminFileTestService {

	public List<adminFileTestVo> adminFileTestList();
	public int InsertadminFileTest(adminFileTestVo adminFileTestVo);
	public int maxSeq();
	public boolean delFile(HttpServletRequest request);
}
