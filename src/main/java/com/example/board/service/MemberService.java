package com.example.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.board.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	MemberDAO memberDao;

	public String passChk(String userid, String  passwd) {
		Map<String, String> map=new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		return memberDao.passChk(map);
	}
	
	public void delete(String userid) {
		memberDao.delete(userid);
	}
	
	public void insert(MemberVO dto) {
		memberDao.insert(dto);
	}
	
	public void update(MemberVO dto) {
		memberDao.update(dto);
	}
	
	public MemberVO detail(String userid) {
		return memberDao.detail(userid);
	}
	
	public List<MemberVO> list() {
		return memberDao.list();
	}
}
