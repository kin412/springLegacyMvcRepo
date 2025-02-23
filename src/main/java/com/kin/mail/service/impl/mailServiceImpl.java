package com.kin.mail.service.impl;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kin.mail.service.mailService;

@Service
public class mailServiceImpl implements mailService {

	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public void sendMail(String to, String title, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); 
			
			//메일 수신 시 표시될 이름 설정
			messageHelper.setFrom("aaa@admin.com","테스트표시이름");
			messageHelper.setSubject(title);
			messageHelper.setTo(to);
			messageHelper.setText(body);
			mailSender.send(message);
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		
	}

}
