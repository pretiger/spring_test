package com.example.board.service;

import java.io.File;

import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.example.board.utils.UploadFileUtils;
import com.example.board.vo.EmailVO;

@Service
public class EmailService {

	private static final Logger logger = LoggerFactory.getLogger(EmailService.class);
	
	@Resource(name = "uploadPath")
	String uploadPath;
	
	@Autowired
	JavaMailSender mailSender;
	
	public void sendMail(EmailVO dto) {
//		첨부파일이 없을 경우 
//		try {
//			MimeMessage msg = mailSender.createMimeMessage();
//			msg.addFrom(new InternetAddress[] {
//					new InternetAddress(dto.getSenderMail(), dto.getSenderName())
//			});
//			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
//			msg.addRecipient(RecipientType.BCC, new InternetAddress(dto.getReceiveMail()));
//			msg.addRecipient(RecipientType.CC, new InternetAddress(dto.getReceiveMail()));
//			msg.setSubject(dto.getSubject(), "utf-8");
//			msg.setText(dto.getMessage() , "utf-8");
//			mailSender.send(msg);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
//		첨부파일이 존재할 경우, 존재하지 않을 경우
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
			messageHelper.setFrom(new InternetAddress(dto.getSenderMail()));
			messageHelper.setTo(new InternetAddress(dto.getReceiveMail()));
			messageHelper.setSubject(dto.getSubject());
			messageHelper.setText(dto.getMessage());
			if(dto.getFiles().getSize() > 0) {
				String fileName = dto.getFiles().getOriginalFilename();
				File target=new File(uploadPath, fileName);
				FileCopyUtils.copy(dto.getFiles().getBytes(), target);
				messageHelper.addAttachment(fileName, target);
				mailSender.send(msg);
				target.delete();
			} else {
				mailSender.send(msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
