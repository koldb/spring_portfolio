package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.MemberService;
import com.spring.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Inject
	MemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//회원가입 get 메서드(회원가입 폼으로 이동)
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String getRegister() throws Exception{
		logger.info("get register");
		return "/board/register";
	}
	
	//회원가입 post(회원가입 누를때 넘어옴)
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception{
		logger.info("post register");
		service.register(vo);
		return "/board/list";
	}
	
	//로그인
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		logger.info("post login");
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		
		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg",false);
		}else {
			session.setAttribute("member", login);
		}
		return "redirect:/login";
	}
	
	//로그아웃
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) throws Exception{
		logger.info("logout");
		
		session.invalidate();
		
		return "redirect:/board/list";
	}
	
	
}
