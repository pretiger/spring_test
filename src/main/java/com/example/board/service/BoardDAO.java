package com.example.board.service;

import java.util.List;
import java.util.Map;

import com.example.board.vo.BoardVO;

public interface BoardDAO {

	public void insertAttach(Map<String, Object> map);
	public void insert(BoardVO dto);
	public int count(Map<String, String> map);
	public List<BoardVO> list(Map<String, Object> map);
}
