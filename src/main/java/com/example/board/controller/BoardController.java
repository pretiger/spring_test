package com.example.board.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.board.service.BoardService;
import com.example.board.utils.Pager;
import com.example.board.vo.BoardVO;

@Controller
@RequestMapping("/board/")
public class BoardController {

	private static final Logger logger =LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardVO dto) {
		boardService.insert(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("write.do")
	public void write() {}
	
	@RequestMapping("list.do")
	public String list(Model model, @RequestParam(defaultValue = "1") int curPage) {
		int count = boardService.count();
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageStart()-1;
		int end = Pager.getPageScale();
		model.addAttribute("list", boardService.list(start, end));
		model.addAttribute("page", pager);
		return "/board/list";
	}
}
