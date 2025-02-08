package com.kin.main.service;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class mainVo {

	private int seq;
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int cnt;
	
}
