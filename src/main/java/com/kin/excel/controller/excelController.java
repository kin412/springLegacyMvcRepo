package com.kin.excel.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kin.excel.service.excelService;
import com.kin.main.service.mainService;
import com.kin.main.service.mainVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class excelController {
	
	@Autowired
	private excelService excelService;
	
	@Autowired
	private mainService mainService;
	
	@ResponseBody
	@RequestMapping(value = "/excel/uploadExcel.do")
	 public int upload(@RequestParam("fileInput") MultipartFile file) {
		excelService.upload(file);
    	return 1;
    }
	
	@ResponseBody
	@RequestMapping(value = "/excel/downloadExcel.do")
	 public int downloadExcel(HttpServletResponse response) throws IOException {
		//전체출력을 위한 no currentpage
		mainVo mainVo = new mainVo();
		
		List<mainVo> list = excelService.downloadData(mainVo);
		
		XSSFWorkbook wb=null;
		Sheet sheet=null;
		Row row=null;
		Cell cell=null; 
		wb = new XSSFWorkbook();
		sheet = wb.createSheet("freeBoard");
		
		//첫행   열 이름 표기 
		int cellCount=0;
		row = sheet.createRow(0); //0번째 행
		cell=row.createCell(cellCount++);
		cell.setCellValue("번호");
		cell=row.createCell(cellCount++);
		cell.setCellValue("제목");
		cell=row.createCell(cellCount++);
		cell.setCellValue("내용");
		cell=row.createCell(cellCount++);
		cell.setCellValue("작성자");
		cell=row.createCell(cellCount++);
		cell.setCellValue("작성일");
		cell=row.createCell(cellCount++);
		cell.setCellValue("조회수");
	
		for(int i=0; i < list.size() ; i++  ) {
			row=sheet.createRow(i+1);  // '열 이름 표기'로 0번째 행 만들었으니까 1번째행부터
			cellCount=0; //열 번호 초기화
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getSeq());
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getTitle());
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getContent());
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getWriter());
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getRegdate());
			cell=row.createCell(cellCount++);
			cell.setCellValue(list.get(i).getCnt());
			
		}
		
		

		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=mainList.xlsx");  //파일이름지정.
		//response OutputStream에 엑셀 작성
		wb.write(response.getOutputStream());
		
    	return 1;
    }
	
}
