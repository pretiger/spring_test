package com.example.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.board.service.BoardService;
import com.example.board.utils.MediaUtils;
import com.example.board.utils.Pager;
import com.example.board.vo.BoardVO;
import com.example.board.vo.ReplyVO;

@Controller
@RequestMapping("/board/")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	@Autowired
	BoardService boardService;
	
	@ResponseBody
	@RequestMapping("preview.do")
	public String preview(@RequestParam int num) {
		return boardService.preview(num);
	}
	
	@ResponseBody
	@RequestMapping("insertComment.do")
	public void insertComment(ReplyVO dto) {
		boardService.insertComment(dto);
	}
	
	@RequestMapping("listComment.do/{bnum}")
	public String listComment(@PathVariable int bnum, Model model) {
		model.addAttribute("list", boardService.listComment(bnum));
		return "board/listComment";
	}
	
	@RequestMapping("insertAnswer.do")
	public String insertAnswer(BoardVO dto, Model model) {
		boardService.insertAnswer(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("answer.do/{num}")
	public String answer(@PathVariable int num, Model model) {
		BoardVO dto = boardService.detail(num);
		dto.setSubject("Re : "+dto.getSubject());
		dto.setContent("============Original Content Text============\n"+dto.getContent());
		model.addAttribute("dto", dto);
		return "board/answer";
	}
	
	@ResponseBody
	@RequestMapping("deleteFile")
	public ResponseEntity<String> deleteFile(String filename) {
		String fileExtention = filename.substring(filename.lastIndexOf(".")+1);
		MediaType mediaType = MediaUtils.getMediaType(fileExtention);
		if(mediaType != null) {
			String start = filename.substring(0, 12);
			String end = filename.substring(14);
			new File(uploadPath + (start + end).replace('/', File.separatorChar)).delete();
		}
		new File(uploadPath + filename.replace('/', File.separatorChar)).delete();
		boardService.deleteAttach(filename);
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("downloadFile")
	public ResponseEntity<byte[]> downloadFile(String filename) throws Exception {
		InputStream inputStream = null;
		HttpHeaders httpHeaders = new HttpHeaders();
		try {
			inputStream = new FileInputStream(uploadPath+filename);
			filename = filename.substring(filename.lastIndexOf("_")+1);
			filename = new String(filename.getBytes("utf-8"), "8859_1");
			httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			httpHeaders.add("Content-Disposition", "attachment;filename=\""+filename+"\"");
			return new ResponseEntity<byte[]>(IOUtils.toByteArray(inputStream), httpHeaders, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if(inputStream != null) inputStream.close();
		}
	}
	
	@ResponseBody
	@RequestMapping("attachList.do/{bnum}")
	public List<String> attachList(@PathVariable int bnum) {
		return boardService.attachList(bnum);
	}
	
	@RequestMapping("update.do")
	public String update(BoardVO dto, Model model) {
		boardService.update(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("detail.do/{num}")
	public String detail(@PathVariable int num, Model model, HttpSession session) {
		boardService.plusCount(num, session);
		model.addAttribute("dto", boardService.detail(num));
		return "board/detail"; 
	}
	
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardVO dto) {
		boardService.insert(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("write.do")
	public void write() {}
	
	@RequestMapping("list.do")
	public String list(Model model, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String searchkey,
			@RequestParam(defaultValue = "") String keyword) {
		int count = boardService.count(searchkey, keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageStart()-1;
		int end = Pager.getPageScale();
		model.addAttribute("list", boardService.list(start, end, searchkey, keyword));
		model.addAttribute("page", pager);
		model.addAttribute("searchkey", searchkey);
		model.addAttribute("keyword", keyword);
		return "board/list";
	}
}
