package com.kin.excel.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kin.main.service.mainVo;

public interface excelService {

	public void upload(MultipartFile file);
	public List<mainVo> downloadData(mainVo mainVo);
	
}
