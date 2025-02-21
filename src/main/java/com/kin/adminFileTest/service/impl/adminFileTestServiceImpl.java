package com.kin.adminFileTest.service.impl;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.kin.adminFileTest.service.adminFileTestService;
import com.kin.adminFileTest.service.adminFileTestVo;

@Service
public class adminFileTestServiceImpl implements adminFileTestService {

	@Autowired
	private adminFileTestMapper mapper;
	
	//String uploadFolder = "C:\\workspace\\springLegacyMvc\\src\\main\\webapp\\resources\\adminMultipleUpload\\";
	@Value("#{systemProp['uploadPath']}")
	private String uploadFolder;

	@Override
	public List<adminFileTestVo> adminFileTestList() {
		
		adminFileTestVo adminFileTestVo = new adminFileTestVo();
		
		return mapper.adminFileTestList(adminFileTestVo);
	}

	@Override
	public int InsertadminFileTest(adminFileTestVo adminFileTestVo) {
		
		return mapper.InsertadminFileTest(adminFileTestVo);
	}

	@Override
	public int maxSeq() {
		
		return mapper.maxSeq();
	}

	@Override
	public boolean delFile(HttpServletRequest request) {
		
		String[] data = request.getParameterValues("chk");
		//값 없음
		String[] data2 = request.getParameterValues("tempArr");
		
		String saveFileName= "";
		File file;
		boolean result = false;
		adminFileTestVo adminFileTestVo = new adminFileTestVo();
		
		System.out.println("--chk[0]: " + data[0]);
		//System.out.println("--tempArr[0] : " + data2[0]); 없는데 접근하려하므로 에러
		
		System.out.println("--chk Arrays : " + Arrays.toString(data));
		System.out.println("--tempArr Arrays : " + Arrays.toString(data2));
		
		for(String seq : data) {
			
			adminFileTestVo.setSeq(Integer.parseInt(seq));
			List<adminFileTestVo> list = mapper.adminFileTestList(adminFileTestVo);
			adminFileTestVo = list.get(0);
			saveFileName = adminFileTestVo.getCode_file_name();
			
			file = new File(uploadFolder + saveFileName);
            result = file.delete();
            
            if(result) {
            	//db delete
    			mapper.delFile(seq);
            }else {
            	break;
            }
		}
		
		return result;
	}
	

}
