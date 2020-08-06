package com.example.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.board.service.EmailService;
import com.example.board.vo.EmailVO;

@Controller
@RequestMapping("/email/")
public class EmailController {

	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	
	@Autowired
	EmailService emailServie;
	
	@RequestMapping("write.do")
	public void write() {}
	
	@RequestMapping("send.do")
	public String send(EmailVO dto, Model model) {
		try {
			emailServie.sendMail(dto);
			model.addAttribute("message", "메일이 발송 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "이메일 발송 실패....!");
		}
		return "email/write";
	}
}
