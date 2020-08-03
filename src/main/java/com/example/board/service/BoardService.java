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

	@Resource(name = "uploadPath")
	String uploadPath;
	
	@Autowired
	BoardDAO boardDao;
	
	public String preview(int num) {
		return boardDao.preview(num);
	}
	
	@Transactional
	public void delete(int num) {
		if(boardDao.listReply(num) != null) {
			boardDao.deleteReply(num);
		}
		List<String> files = boardDao.listAttach(num);
		if(files != null) {
			for(String file : files) {
				boardDao.deleteAttach(file);
				new File(uploadPath + file.replace('/', File.separatorChar)).delete();
			}
		}
		boardDao.delete(num);
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
	
	public  List<ReplyVO> insertReply(Map<String, Object> map) {
		boardDao.insertReply(map);
		return boardDao.listReply((int)map.get("bnum"));
	}
	
	@Transactional
	public void insertAnswer(BoardVO dto) {
		dto.setSubstep(dto.getSubstep() + 1);
		dto.setSublevel(dto.getSublevel() + 1);
		Map<String, Object> map2 = new HashMap<>();
		map2.put("subgroup", dto.getSubgroup());
		map2.put("substep", dto.getSubstep());
		boardDao.plusStep(map2);;
		boardDao.insertAnswer(dto);
		if(dto.getFiles() != null) {
			MultipartFile[] files = dto.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					String fullName = "";
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, fileName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", dto.getNum());
						boardDao.insertAttach(map);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	public void deleteAttach(String fullName) {
		boardDao.deleteAttach(fullName);
	}
	
	public List<String> listAttach(int bnum) {
		return boardDao.listAttach(bnum);
	}
	
	@Transactional
	public void update(BoardVO dto) {
		boardDao.update(dto);
		if(dto.getFiles() != null) {
			MultipartFile[] files = dto.getFiles();
			for(MultipartFile file : files) {
				if(file.getSize() > 0) {
					String fileName = file.getOriginalFilename();
					String fullName = "";
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, fileName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", dto.getNum());
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
					String fileName = file.getOriginalFilename();
					String fullName = "";
					try {
						fullName = UploadFileUtils.uploadFile(uploadPath, fileName, file.getBytes());
						Map<String, Object> map = new HashMap<>();
						map.put("fullName", fullName);
						map.put("bnum", dto.getNum());
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
		map.put("start", start);
		map.put("end", end);
		map.put("searchkey", searchkey);
		map.put("keyword", "%"+keyword+"%");
		return boardDao.list(map);
	}
}
