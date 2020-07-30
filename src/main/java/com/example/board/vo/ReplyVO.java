package com.example.board.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ReplyVO {
	private int rnum;
	private int bnum;
	private String replytext;
	private String replyer;
	private String name;
	private Date regdate;
}
