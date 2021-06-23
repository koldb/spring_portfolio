package com.spring.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.BoardService;
import com.spring.service.ReplyService;
import com.spring.vo.BoardVO;
import com.spring.vo.Criteria;
import com.spring.vo.PageMaker;
import com.spring.vo.ReplyVO;
import com.spring.vo.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	//게시글 작성 뷰
	@RequestMapping(value="/board/writeView", method=RequestMethod.GET)
	public String writeView() throws Exception{
		logger.info("writeView");
		return "board/writeView";
	}
	
	//게시글 작성
	@RequestMapping(value="/board/write", method=RequestMethod.POST)
	public String writer(BoardVO boardVO, RedirectAttributes rttr) throws Exception{
		logger.info("write");
		service.write(boardVO);
		rttr.addFlashAttribute("result","writeOK");
		return "redirect:/board/list";
	}
	
	//게시글 리스트
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(Model model,@ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list");
		model.addAttribute("list", service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker",pageMaker);
		
		return "board/list";
	}
	
	//게시글 읽기
	@RequestMapping(value="/readView", method=RequestMethod.GET)
	public String read(BoardVO boardVO,@ModelAttribute("scri") SearchCriteria scri ,Model model) throws Exception{
		logger.info("read");
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno());
		model.addAttribute("replyList", replyList);
		
		return "board/readView";
	}
	
	//게시글 수정 뷰
	@RequestMapping(value="/updateView", method=RequestMethod.GET)
	public String updateView(BoardVO boardVO,@ModelAttribute("scri") SearchCriteria scri ,Model model) throws Exception{
		logger.info("updateView");
		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		return "board/updateView";
	}

	//게시글 수정
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(BoardVO boardVO,@ModelAttribute("scri")SearchCriteria scri ,RedirectAttributes rttr) throws Exception{
		logger.info("update");
		service.update(boardVO);
		
		rttr.addAttribute("page",scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType",scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		rttr.addFlashAttribute("result","updateOK");
		return "redirect:/board/list";
	}
	
	//게시글 삭제
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(BoardVO boardVO,@ModelAttribute("scri") SearchCriteria scri ,RedirectAttributes rttr) throws Exception{
		logger.info("delete");
		service.delete(boardVO.getBno());
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		rttr.addFlashAttribute("result", "deleteOK");
		return "redirect:/board/list";
	}
	
	//댓글 작성
	@RequestMapping(value="/replyWrite", method=RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("replyWrite");
		
		replyService.writeReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum",scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/readView";
		
	}
	
	/*
	 * //댓글 수정 get
	 * 
	 * @RequestMapping(value = "/replyUpdateView", method = RequestMethod.GET)
	 * public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model)
	 * throws Exception{ logger.info("reply update");
	 * 
	 * model.addAttribute("replyUpdate", replyService.selectReply(vo.getBno()));
	 * model.addAttribute("scri", scri);
	 * 
	 * return "board/replyUpdateView"; }
	 * 
	 * //댓글 수정 post
	 * 
	 * @RequestMapping(value = "/replyUpdate", method = RequestMethod.POST) public
	 * String replyUpdate(ReplyVO vo, SearchCriteria scri,RedirectAttributes rttr )
	 * throws Exception{ logger.info("reply update");
	 * 
	 * replyService.updateReply(vo);
	 * 
	 * rttr.addAttribute("bno", vo.getBno()); rttr.addAttribute("page",
	 * scri.getPage()); rttr.addAttribute("perPageNum", scri.getPerPageNum());
	 * rttr.addAttribute("searchType", scri.getSearchType());
	 * rttr.addAttribute("keyword", scri.getKeyword());
	 * 
	 * return "redirect:/board/readView"; }
	 * 
	 * //댓글 삭제 get
	 */	
	
	
	
	
	
}
