package com.example.board.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.board.service.MemberService;
import com.example.board.vo.MemberVO;

@Controller
@RequestMapping("/member/")
public class MemberController {

	private static final Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session, Model model) {
		session.invalidate();
		model.addAttribute("message", "logout!");
		return "member/login";
	}
	
	@RequestMapping("passChk.do")
	public ModelAndView passChk(MemberVO dto, ModelAndView mav, HttpSession session) {
		String name=memberService.passChk(dto.getUserid(), dto.getPasswd());
		logger.info("===========name========:"+"["+name+"]");
		if(name != null) {
			session.setAttribute("userid", dto.getUserid());
			session.setAttribute("name", name);
			mav.setViewName("home");
			mav.addObject("message", "Welcome to Mr."+name);
		} else {
			mav.setViewName("member/login");
			mav.addObject("message", "Userid or Password missmatch!");
		}
		return mav;
	}
	
	@RequestMapping("login.do")
	public void login() {}
	
	@RequestMapping("delete.do/{userid}")
	public String delete(@PathVariable String userid) {
		memberService.delete(userid);
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("insert.do")
	public String insert(MemberVO dto, Model model) {
	logger.info("============dto:"+dto);
		memberService.insert(dto);
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("join.do")
	public void join() {}
	
	@RequestMapping("update.do")
	public String update(@ModelAttribute MemberVO dto, Model model) {
		memberService.update(dto);
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("detail.do/{userid}")
	public String detail(@PathVariable String userid, Model model) {
		model.addAttribute("dto", memberService.detail(userid));
		return "member/detail";
	}
	
	@RequestMapping("list.do")
	public String list(Model model) {
		model.addAttribute("list", memberService.list());
		return "member/list";
	}
}
