package com.example.board.service;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.board.vo.EmailVO;

@Service
public class EmailService {

	@Autowired
	JavaMailSender mailSender;
	
	public void sendMail(EmailVO dto) {
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			msg.addFrom(new InternetAddress[] {
					new InternetAddress(dto.getSenderMail(), dto.getSenderName())
			});
			msg.setSubject(dto.getSubject(), "utf-8");
			msg.setText(dto.getMessage() , "utf-8");
			mailSender.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
