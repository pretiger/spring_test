package com.example.board.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.board.utils.UploadFileUtils;
import com.example.board.vo.BoardVO;
import com.example.board.vo.ReplyVO;

@Service
public class BoardService {

	@Resource(name="uploadPath")
	String uploadPath;
	
	@Autowired
	BoardDAO boardDao;
	
	@Transactional
	public void delete(int num) {
		List<String> fullNames = boardDao.attachList(num); 
		if(boardDao.countComment(num) > 0) {
			boardDao.deleteComment(num);
		}
		if(fullNames.size() > 0) {
			for(String fullName : fullNames) {
				boardDao.deleteAttach(fullName);
				new File(uploadPath + fullName.replace('/', File.separatorChar)).delete();
			}
		}
		boardDao.delete(num);
	}
	
	public String preview(int num) {
		return boardDao.preview(num);
	}
	
	public void insertComment(ReplyVO dto) {
		boardDao.insertComment(dto);
	}
	
	public List<ReplyVO> listComment(int bnum) {
		return boardDao.listComment(bnum);
	}
	
	@Transactional
	public void insertAnswer(BoardVO dto) {
		dto.setSubstep(dto.getSubstep()+1);
		dto.setSublevel(dto.getSublevel()+1);
		boardDao.plusStep(dto);
		boardDao.insertAnswer(dto);
		if(dto.getFiles() != null) {
			MultipartFile[] files = dto.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalName = file.getOriginalFilename();
					String fullName = "";
					int bnum = dto.getNum();
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, originalName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public void plusCount(int num, HttpSession session) {
		long read_time = 0;
		if(session.getAttribute("read_time_"+num) != null) {
			read_time = (long)session.getAttribute("read_time_"+num);
		}
		long current_time = System.currentTimeMillis();
		if(current_time - read_time > 5*1000) {
			boardDao.plusCount(num);
			session.setAttribute("read_time_"+num, current_time);
		}
	}
	
	public void deleteAttach(String fullName) {
		boardDao.deleteAttach(fullName);
	}
	
	public List<String> attachList(int bnum) {
		return boardDao.attachList(bnum);
	}
	
	@Transactional
	public void update(BoardVO dto) {
		boardDao.update(dto);
		if(dto.getFiles() != null) {
			MultipartFile[] files = dto.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalName = file.getOriginalFilename();
					String fullName = "";
					int bnum = dto.getNum();
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, originalName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public BoardVO detail(int num) {
		return boardDao.detail(num);
	}
	
	@Transactional
	public void insert(BoardVO dto) {
		boardDao.insert(dto);
		if(dto.getFiles() != null) {
			MultipartFile[] files = dto.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String originalName = file.getOriginalFilename();
					String fullName = "";
					int bnum = dto.getNum();
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, originalName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", bnum);
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public int count(String searchkey, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("searchkey", searchkey);
		map.put("keyword", "%"+keyword+"%");
		return boardDao.count(map);
	}
	
	public List<BoardVO> list(int start, int end, String searchkey, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("start",  start);
		map.put("end", end);
		map.put("searchkey", searchkey);
		map.put("keyword", "%"+keyword+"%");
		return boardDao.list(map);
	}
}
