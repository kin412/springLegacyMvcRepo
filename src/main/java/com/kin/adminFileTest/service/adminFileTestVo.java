package com.kin.adminFileTest.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class adminFileTestVo {

	private int seq;
	private String real_file_name;
	private String code_file_name;
	private String regdate;
	private List<MultipartFile> uploadFile;
	
}
