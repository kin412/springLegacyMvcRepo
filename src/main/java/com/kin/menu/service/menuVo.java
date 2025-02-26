package com.kin.menu.service;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class menuVo {

	private int id;
	private int parent_id;
	private String name;
	private int list_order;
	private String menu_url;
	private String menu_visible;
	
}
