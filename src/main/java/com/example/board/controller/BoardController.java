package com.example.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.board.service.BoardDAO;
import com.example.board.service.BoardService;
import com.example.board.utils.MediaUtils;
import com.example.board.utils.Pager;
import com.example.board.vo.BoardVO;
import com.example.board.vo.ReplyVO;

@Controller
@RequestMapping("/board/")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name = "uploadPath")
	String uploadPath;
	
	@Autowired
	BoardService boardService;
	@Autowired
	BoardDAO boardDao;
	
	@ResponseBody
	@RequestMapping("preview.do/{num}")
	public String preview(@PathVariable int num) {
		return boardService.preview(num);
	}
	
	@RequestMapping("delete.do")
	public String delete(int num) {
		boardService.delete(num);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("listingAttach.do/{bnum}")
	public String listingAttach(@PathVariable int bnum, Model model) {
		model.addAttribute("list", boardDao.listReply(bnum));
		return "board/comment";
	}
	
	@RequestMapping("insertAttach.do")
	public String insertAttach(String replytext, String replyer, int bnum, Model model) {
		Map<String, Object> map = new HashMap<>();
		map.put("replytext", replytext);
		map.put("replyer", replyer);
		map.put("bnum", bnum);
		List<ReplyVO> list = boardService.insertReply(map);
		model.addAttribute("list", list);
		return "board/comment";
	}
	
	@RequestMapping("insertAnswer.do")
	public String insertAnswer(BoardVO dto) {
		boardService.insertAnswer(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("answer.do/{num}")
	public String answer(@PathVariable int num, Model model) {
		BoardVO dto = boardService.detail(num);
		dto.setSubject("Re : " + dto.getSubject());
		dto.setContent("============Original Content============\n" + dto.getContent());
		model.addAttribute("dto", dto);
		return "board/answer";
	}
	
	@ResponseBody
	@RequestMapping("deleteFile.do")
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
	@RequestMapping("downloadFile.do")
	public ResponseEntity<byte[]> downloadFile(String fileName) throws Exception {
		InputStream inputStream=null;
		HttpHeaders httpHeaders=new HttpHeaders();
		try {
			inputStream=new FileInputStream(uploadPath+fileName);
			fileName=fileName.substring(fileName.lastIndexOf("_")+1);
			fileName=new String(fileName.getBytes("utf-8"), "8859_1");
			httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			httpHeaders.add("Content-Disposition", "attachment;filename=\""+fileName+"\"");
			return new ResponseEntity<byte[]>(IOUtils.toByteArray(inputStream), httpHeaders, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if(inputStream != null) inputStream.close();
		}
	}
	
	@ResponseBody
	@RequestMapping("listAttach.do/{bnum}") 
	public List<String> listAttach(@PathVariable int bnum) {
		return boardService.listAttach(bnum);
	}
	
	@RequestMapping("update.do")
	public String update(BoardVO dto) {
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
	public String insert(BoardVO dto) {
		boardService.insert(dto);
		return "redirect:/board/list.do";
	}
	
	@RequestMapping("write.do")
	public void write() {}
	
	@RequestMapping("list.do")
	public String lidt(Model model, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "all") String searchkey,
			@RequestParam(defaultValue = "") String keyword) {
		int count = boardService.count(searchkey, keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageStart() - 1;
		int end = Pager.getPageScale();
		model.addAttribute("list", boardService.list(start, end, searchkey, keyword));
		model.addAttribute("page", pager);
		model.addAttribute("searchkey", searchkey);
		model.addAttribute("keyword", keyword);
		return "board/list";
	}
}
