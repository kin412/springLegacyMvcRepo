package com.kin.adminFileTest.service;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class multiUploadVo {

	private List<adminFileTestVo> fileList;
	
}
