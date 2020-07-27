package com.example.board.vo;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class MemberVO {
    // 계정 
    private String userid;
    // 비밀번호 
    private String passwd;
    // 이름 
    private String name;
    // 이메일 
    private String email;
    // 가입일 
    private Date join_date; 
}
