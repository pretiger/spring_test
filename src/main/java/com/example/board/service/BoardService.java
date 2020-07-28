package com.example.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.board.utils.UploadFileUtils;
import com.example.board.vo.BoardVO;

@Service
public class BoardService {

	@Resource(name="uploadPath")
	String uploadPath;
	
	@Autowired
	BoardDAO boardDao;
	
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
		Map<String, String> map = new HashMap<>();
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
