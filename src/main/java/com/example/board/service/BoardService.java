package com.example.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.board.vo.BoardVO;

@Service
public class BoardService {

	@Autowired
	BoardDAO boardDao;
	
	public void insert(BoardVO dto) {
		
		boardDao.insert(dto);
	}
	
	public int count() {
		return boardDao.count();
	}
	
	public List<BoardVO> list(int start, int end) {
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		return boardDao.list(map);
	}
}
