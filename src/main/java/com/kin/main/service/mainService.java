package com.kin.main.service;

import java.util.List;
import java.util.Map;

public interface mainService {

	public List<mainVo> search(mainVo mainVo);
	public Map<String, Object> searchPg(mainVo mainVo);
}
