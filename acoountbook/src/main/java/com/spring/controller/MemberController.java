package com.spring.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	
}
