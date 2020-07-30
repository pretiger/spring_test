package com.example.board.service;

import java.util.List;
import java.util.Map;

import com.example.board.vo.BoardVO;
import com.example.board.vo.ReplyVO;

public interface BoardDAO {

	public String preview(int num);
	public void insertComment(ReplyVO dto);
	public List<ReplyVO> listComment(int bnum);
	public void plusStep(BoardVO dto);
	public void insertAnswer(BoardVO dto);
	public void plusCount(int num);
	public void deleteAttach(String fullName);
	public List<String> attachList(int bnum);
	public void update(BoardVO dto);
	public BoardVO detail(int num);
	public void insertAttach(Map<String, Object> map);
	public void insert(BoardVO dto);
	public int count(Map<String, Object> map);
	public List<BoardVO> list(Map<String, Object> map);
}
