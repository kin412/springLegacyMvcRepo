package com.kin.main.service;

import com.kin.comm.service.pagingVo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class mainVo extends pagingVo {

	private int seq;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int cnt;
	
}
