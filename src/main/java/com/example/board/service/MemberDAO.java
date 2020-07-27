package com.example.board.service;

import java.util.List;
import java.util.Map;

import com.example.board.vo.MemberVO;

public interface MemberDAO {

	public String passChk(Map<String, String> map);
	public void delete(String userid);
	public void insert(MemberVO dto);
	public void update(MemberVO dto);
	public List<MemberVO> list();
	public MemberVO detail(String userid);
}
