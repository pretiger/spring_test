package com.example.board.service;

import java.util.List;
import java.util.Map;

import com.example.board.vo.BoardVO;

public interface BoardDAO {

	public void insert(BoardVO dto);
	public int count();
	public List<BoardVO> list(Map<String, Integer> map);
}
