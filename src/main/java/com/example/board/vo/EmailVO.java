package com.example.board.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class EmailVO {
	private String senderName; //발신자 이름
	private String senderMail; //발신자 이메일 주소
	private String receiveMail; //수진자 이메일 주소
	private String subject; //제목
	private String message; //본눔
}
