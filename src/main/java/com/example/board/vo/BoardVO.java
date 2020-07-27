package com.example.board.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class BoardVO {
    // 번호 
    private int num;
    // 작성자 
    private String writer;
    // 제목 
    private String subject;
    // 내용 
    private String content;
    // 댓글그룹 
    private int subgroup;
    // 댓글단계 
    private int substep;
    // 댓글레벨 
    private int sublevel;
    // 조회수 
    private int viewcount;
    private int cnt;
    private MultipartFile[] files;
    // 작성일 
    private Date regdate;
}
