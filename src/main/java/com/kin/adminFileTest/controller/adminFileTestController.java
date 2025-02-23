package com.kin.adminFileTest.controller;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Array;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kin.adminFileTest.service.adminFileTestService;
import com.kin.adminFileTest.service.adminFileTestVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class adminFileTestController {
	
	@Autowired
	private adminFileTestService adminFileTestService;
	
	//String uploadFolder = "C:\\workspace\\springLegacyMvc\\src\\main\\webapp\\resources\\adminMultipleUpload\\";
	@Value("#{systemProp['uploadPath']}")
	private String uploadFolder;
	
	@RequestMapping(value = "/adminFileTest/adminFileTest.do")
	public String adminFileTest() {
		
		log.info("--/adminFileTest/adminFileTest.do");
		
		return "adminFileTest/adminFileTest";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminFileTest/adminFileList.do")
	public List<adminFileTestVo> adminFileList() {
		
		return adminFileTestService.adminFileTestList();
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminFileTest/uploadFile.do")
	public void uploadFile(@ModelAttribute adminFileTestVo adminFileTestVo) {
		//MultipartHttpServletRequest request
		//매개변수 List<MultipartFile>, MultipartFile, MultipartFile[] 도 가능. 근데 나는 왜인지 안된다; 버전이 낮아서 그런가?
		
		log.info("--update ajax post......");
		
		List<MultipartFile> fileList = adminFileTestVo.getUploadFile();
		log.info("--fileList.size : " +fileList.size() );
		
		/* 매개변수로 MultipartHttpServletRequest request 로 받았을떼 - 기본
		List<MultipartFile> fileList = request.getFiles("uploadFile");
		log.info("--fileList.size : " +fileList.size() );
		*/
		
		// 화면단에서 formData2를 보냈을 경우
		/*
		fileList = request.getFiles("uploadFiles");
		System.out.println("--fileList2.size : " +fileList.size() );
		*/
		
		// 파일저장 시 그냥 한경로에 다 때려박는지, 날짜별로 분류한다던지의 기준이 있는지 알고 그게맞게 로직을짜야함.
		
		for(MultipartFile multipartFile : fileList) {
			log.info("--==========================");
			log.info("--upload file name: "+ multipartFile.getOriginalFilename());
			log.info("--upload file size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			String uuidUploadFileName = "";
			
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") +1);
			log.info("--only file name: " + uploadFileName );
			
			//중복 방지 UUID 적용
			UUID uuid = UUID.randomUUID();
			uuidUploadFileName = uuid.toString()+"_"+uploadFileName;
			
			File saveFile = new File(uploadFolder, uuidUploadFileName);
			
			adminFileTestVo.setReal_file_name(uploadFileName);
			adminFileTestVo.setCode_file_name(uuidUploadFileName);
			
			try {
				//지정된 경로에 해당파일 업로드
				multipartFile.transferTo(saveFile);
				
				//maxSeq
				adminFileTestVo.setSeq(adminFileTestService.maxSeq()+1);
				
				//파일 정보 db저장
				adminFileTestService.InsertadminFileTest(adminFileTestVo);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
			
		}
		
	}
	
	//파일 다운로드 get요청1
	//produces = MediaType.APPLICATION_OCTET_STREAM_VALUE 이거 없어도 되는데??
	@ResponseBody
	@RequestMapping(value = "/adminFileTest/fileDown.do", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	//@ModelAttribute adminFileTestVo adminFileTestVo, HttpServletResponse response
	public ResponseEntity<Resource> fileDown(String fileName) throws IOException {
		
		//System.out.println("-- vo.toString : " + adminFileTestVo.toString());
		
		//String saveFileName = adminFileTestVo.getCode_file_name();
		//String originalFileName = adminFileTestVo.getReal_file_name();
		
		//System.out.println("--saveFileName : " + saveFileName);
		
		String path = uploadFolder + fileName; // 경로에 접근할 때 역슬래시('\') 사용
		System.out.println("-- path1 : " + path);
		
		Resource resource = new FileSystemResource(path);
		
		System.out.println("--resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		System.out.println("--resourceName : " + resourceName);
		
		org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
		
		headers.add("Content-Disposition",
				"attachment; filename=" + new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		
		
		
        //ContentType설정
        /*
        if (fileInfo.getGroupId().equals("image")) {
            response.setContentType(MediaType.MULTIPART_FORM_DATA);
        }else {
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        }
        */
		
	}
	
	//파일다운로드 get요청2
	@ResponseBody
	@RequestMapping(value = "/adminFileTest/fileDown2.do")
	public void fileDown2(@ModelAttribute adminFileTestVo adminFileTestVo, HttpServletResponse response) throws IOException {
		
		String fileName = adminFileTestVo.getCode_file_name();
		
		System.out.println("--fileName : " + fileName);
		
		String saveFileName = fileName;
		
		//System.out.println("--saveFileName : " + saveFileName);
		
		String path = uploadFolder + saveFileName; // 경로에 접근할 때 역슬래시('\') 사용
		System.out.println("-- path1 : " + path);

		//path = URLEncoder.encode(path, "UTF-8");
		//System.out.println("--path2  : " + path);
		
		
		/*
    	File file = new File(path);
    	
    	System.out.println("--file.getName : " + file.getName());
    	
    	//response.setContentType("application/vnd.ms-excel");
    	//response.setCharacterEncoding("UTF-8");
    	response.setHeader("Content-Disposition", "attachment;filename=" + file.getName()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더
    	
    	FileInputStream fileInputStream;
    	
		try {
			fileInputStream = new FileInputStream(path);
			OutputStream out = response.getOutputStream();
	    	
	    	int read = 0;
	        byte[] buffer = new byte[1024];
	        while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
	            out.write(buffer, 0, read);
	        }
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 2;
		}catch (IOException e) {
			e.printStackTrace();
			return 3;
		}
		
		return 1;
    	*/
		
		
		File downloadFile = new File(path);
		
		byte fileByte[];
		
		try {
			fileByte = FileUtils.readFileToByteArray(downloadFile);
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			
			response.setHeader("Content-Disposition", "attachment; fileName=\""+ URLEncoder.encode(saveFileName, "UTF-8")+"\";"); 
			response.setHeader("Content-Transfer-Encoding", "binary");
			
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminFileTest/delFile.do")
	public boolean delFile(HttpServletRequest request) {
		
		return adminFileTestService.delFile(request);
	}
	
}
