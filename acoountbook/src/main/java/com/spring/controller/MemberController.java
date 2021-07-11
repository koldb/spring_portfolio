package com.spring.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//로그인 팝업
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login() throws Exception{
		logger.info("get login");
		return "/board/login";
	}
	
	//로그인
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(MemberVO vo,  HttpServletRequest req, RedirectAttributes rttr) throws Exception{
		logger.info("post login");
		
		HttpSession session = req.getSession();
		MemberVO login = service.login(vo);
		
		if(login == null) {
			session.setAttribute("member", null);
			//rttr.addFlashAttribute("msg", false);
			session.setAttribute("msg", false);
			System.out.println("로그인 null");
		}else {
			session.setAttribute("member", login);
			session.setAttribute("msg", null);
			System.out.println("성공");
		}
		return "redirect:/board/list";
	}
	
	//로그아웃
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) throws Exception{
		logger.info("logout");
		
		session.invalidate();
		
		return "redirect:/board/list";
	}
	
	//회원정보 수정뷰
	@RequestMapping(value="memberModifyView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception{
		logger.info("memberModifyView");
		
		return "board/memberModifyView";
	}
	
	//회원정보 수정
	@RequestMapping(value="memberModify", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpSession session) throws Exception{
		logger.info("memberModify");
		
		service.memberUpdate(vo);
		/* session.invalidate(); */
		
		return "redirect:/board/list";
		
	}
	
	//회원탈퇴 뷰
	@RequestMapping(value="memberDeleteView" , method = RequestMethod.GET)
	public String memberDeleteView() throws Exception{
		logger.info("memberDeleteView");
		
		return "board/memberDeleteView";
	}
	
	
	
	//회원탈퇴
	@RequestMapping(value="memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception{
		logger.info("memberdelete");
		
//		//세션의 member를 가져와 member 변수에 넣어줌
//		MemberVO member = (MemberVO) session.getAttribute("member");
//		//세션에 들어있는 비밀번호
//		String sessionPass = member.getUserPass();
//		//vo에 들어있는 비밀번호
//		String voPass = vo.getUserPass();
//		
//		if(!(sessionPass.equals(voPass))) {
//			rttr.addFlashAttribute("msg",false);
//			return "redirect:/member/memberModifyView";
//		}
		
		service.memberDelete(vo);
		session.invalidate();
		return "redirect:/board/list";
	}
	
	//패스워드 체크
	@ResponseBody
	@RequestMapping(value="/passChk", method = RequestMethod.POST)
	public int passChk(MemberVO vo) throws Exception{
		
		int result = service.passChk(vo);
		return result;
	}
	
	//중복 아이디 체크
	@ResponseBody
	@RequestMapping(value="/idChk", method =RequestMethod.POST )
	public int idChk(MemberVO vo) throws Exception{
		int result = service.idChk(vo);
		return result;
	}
	
	
	
	
}
