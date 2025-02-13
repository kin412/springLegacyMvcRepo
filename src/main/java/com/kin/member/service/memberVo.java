package com.kin.member.service;

import java.util.List;

import lombok.Data;

@Data
public class memberVo {

	private String userid;
	private String userpw;
	private String username;
	private String enabled;
	private List<authVo> authlist;
	
}
