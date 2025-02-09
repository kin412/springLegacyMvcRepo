package com.kin.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kin.comm.service.pagingVo;
import com.kin.main.service.mainService;
import com.kin.main.service.mainVo;

@Service
public class mainServiceImpl implements mainService {

	@Autowired
	private mainMapper mapper;

	@Override
	public List<mainVo> search(mainVo mainVo) {
		
		return mapper.search(mainVo);
	}

	@Override
	public Map<String, Object> searchPg(mainVo mainVo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		pagingVo pagingVo = new pagingVo();
		
		int totalCnt = mapper.totalCnt(mainVo);
		//페이징
		pagingVo.setCurrentPage(mainVo.getCurrentPage());
		pagingVo.setPageSize(mainVo.getPageSize());
		pagingVo.setPaging(totalCnt);
		
		mainVo.setCurrentPage(pagingVo.getCurrentPage());
		mainVo.setPageSize(pagingVo.getPageSize());
		
		List boardList = mapper.search(mainVo);
		
		map.put("boardList", boardList);
		map.put("totalCnt", totalCnt);
		map.put("pagingVo", pagingVo);
		
		return map;
	}

	@Override
	public mainVo selectDetail(int seq) {
		
		return mapper.selectDetail(seq);
	}

	@Override
	public Map<String, Object> createAndUpdateDetail(mainVo mainVo) {
		
		Map map = new HashMap<String, Object>();
		int seq = mainVo.getSeq();
		
		if(seq != 0) {
			//업데이트
			int updateFlg = mapper.updateDetail(mainVo);
			System.out.println("--updateFlg : " + updateFlg);
			//mapper.search(mainVo);
			if(updateFlg == 1) {
				map.put("message", "수정이 완료되었습니다");
			}else {
				map.put("message", "수정이 실패했습니다.");
			}
		}else {
			//등록
			mapper.insertDetail(mainVo);
			map.put("message", "등록이 완료되었습니다");
			//마지막 글번호 가져오기
			seq = mapper.maxSeq();
			
		}
		
		map.put("seq", seq);
		
		
		return map;
	}

	@Override
	public Map<String, Object> deleteDetail(mainVo mainVo) {
		
		Map map = new HashMap<String, Object>();
		
		int delFlg = mapper.deleteDetail(mainVo);
		
		if(delFlg == 1) {
			map.put("message", "삭제되었습니다.");
		}else {
			map.put("message", "삭제 실패했습니다.");
		}
		
		
		return map;
	}
	
	
	
	

}
