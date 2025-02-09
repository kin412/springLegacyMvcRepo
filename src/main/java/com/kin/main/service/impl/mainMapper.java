package com.kin.main.service.impl;

import java.util.List;

import com.kin.main.service.mainVo;

public interface mainMapper {
	
	public List<mainVo> search(mainVo mainVo);
	public int totalCnt(mainVo mainVo);
	public mainVo selectDetail(int seq);
	public int updateDetail(mainVo mainVo);
	public int deleteDetail(mainVo mainVo);
	public int insertDetail(mainVo mainVo);
	public int maxSeq();
}
