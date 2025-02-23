package com.kin.excel.service.impl;

import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kin.excel.service.excelService;
import com.kin.main.service.mainVo;
import com.kin.main.service.impl.mainMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class excelServiceImpl implements excelService {
	
	@Autowired
	private mainMapper mapper;

	@Override
	public void upload(MultipartFile file) {
		
		//List<mainVo> mainVoList = new ArrayList<mainVo>();
		mainVo mainVo = null;
	    
        String fileExtsn = FilenameUtils.getExtension(file.getOriginalFilename()); // 파일 Original 이름 불러오기 ex) 전문가.xlsx
        
        Workbook workbook = null;
        
        try {
	        // 엑셀 97 - 2003 까지는 HSSF(xls),  엑셀 2007 이상은 XSSF(xlsx)
	        if (fileExtsn.equals("xls")) {
	        	workbook = new HSSFWorkbook(file.getInputStream());
	        } else {
	            workbook = new XSSFWorkbook(file.getInputStream());
	        }
	        
	       // 엑셀파일에서 첫번째 시트 불러오기
           Sheet worksheet = workbook.getSheetAt(0);
           
           // getPhysicalNumberOfRow 는 행의 갯수를 불러오는 매소드
           for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {
        	   
        	   // i번째 행 정보 가져오기
               Row row = worksheet.getRow(i);
               
               if (row != null) {
            	   
            	   // i번째 행의 j번째 셀 정보 가져오기
            	   for (int j = 0; j <= 2; j++) {
            		   
            		   Cell cell = row.getCell(j);
                       String value = "";
                       if (cell == null) {
                    	   log.info("--cell is null");
                           continue;
                       } else {
                    	   
                    	   switch (cell.getCellTypeEnum()) {
                    	   case FORMULA:
                               value = cell.getCellFormula();
                               break;
                            case NUMERIC:
                               if (HSSFDateUtil.isCellDateFormatted(cell)) { // 숫자- 날짜 타입이다.
                                    //value = formatter.format(cell.getDateCellValue());
                               } else {
                                    double numericCellValue = cell.getNumericCellValue();
                                    value = String.valueOf(numericCellValue);
                                    if (numericCellValue == Math.rint(numericCellValue)) {
                                        value = String.valueOf((int) numericCellValue);
                                    } else {
                                        value = String.valueOf(numericCellValue);
                                    }
                               }
                               break;
                            case STRING:
                               value = cell.getStringCellValue() + "";
                               break;
                            case BLANK:
                               value = cell.getBooleanCellValue() + "";
                               break;
                            case ERROR:
                               value = cell.getErrorCellValue() + "";
                               break;
                            default:
                               value = cell.getStringCellValue();
                               break;
						   }
                    	   
                       }
                       
                       log.info("--value : " + value);
            		   if(j == 0) {
            			   mainVo = new mainVo();
            			   mainVo.setTitle(value);
            		   }else if(j == 1) {
            			   mainVo.setWriter(value);
            		   }else {
            			   mainVo.setContent(value);
            			   mapper.insertDetail(mainVo);
            		   }
                       
            	   }
            	   
               }
        	   
           }
           
           
	        
        }catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	public List<mainVo> downloadData(mainVo mainVo) {
		return mapper.search(mainVo);
	}

}
