package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.gson.JsonObject;
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

	// 게시글 작성 뷰
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public String writeView() throws Exception {
		logger.info("writeView");
		return "board/writeView";
	}

	// 게시글 작성
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String writer(BoardVO boardVO, RedirectAttributes rttr) throws Exception {
		logger.info("write");
		service.write(boardVO);
		
		rttr.addFlashAttribute("result", "writeOK");
		return "redirect:/board/list";
	}

	// 게시글 리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri, HttpServletRequest request) throws Exception {
		logger.info("list");
		model.addAttribute("list", service.list(scri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));

		model.addAttribute("pageMaker", pageMaker);
		return "board/list";
	}

	// 게시글 읽기
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		logger.info("read");
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno());
		model.addAttribute("replyList", replyList);

		return "board/readView";
	}

	// 게시글 수정 뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model)
			throws Exception {
		logger.info("updateView");
		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		return "board/updateView";
	}

	// 게시글 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr)
			throws Exception {
		logger.info("update");
		service.update(boardVO);

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		rttr.addFlashAttribute("result", "updateOK");
		return "redirect:/board/list";
	}

	// 게시글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr)	throws Exception {
		logger.info("delete");
		service.delete(boardVO.getBno());

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		rttr.addFlashAttribute("result", "deleteOK");
		return "redirect:/board/list";
	}

	// 댓글 작성
	@RequestMapping(value = "/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("replyWrite");

		replyService.writeReply(vo);

		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());

		return "redirect:/board/readView";

	}

	//댓글 수정
	//댓글 수정 GET
		@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET)
		public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
			logger.info("reply Write");
			
			model.addAttribute("replyUpdate", replyService.selectReply(vo.getRno()));
			model.addAttribute("scri", scri);
			
			return "board/replyUpdateView";
		}
		
		//댓글 수정 POST
		@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
		public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
			logger.info("reply update");
			
			replyService.updateReply(vo);
			
			rttr.addAttribute("bno", vo.getBno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:/board/readView";
		}
	
		//댓글 삭제 GET
		@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
		public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model,RedirectAttributes rttr) throws Exception {
			logger.info("reply Write");
			
			model.addAttribute("replyDelete", replyService.selectReply(vo.getRno()));
			model.addAttribute("scri", scri);
			
			

			return "board/replyDeleteView";
		}
		
		//댓글 삭제
		@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
		public String replyDelete(ReplyVO vo, RedirectAttributes rttr,SearchCriteria scri) throws Exception {
			logger.info("reply delete");
			
			replyService.deleteReply(vo);
			
			rttr.addAttribute("bno", vo.getBno());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:/board/readView";
		}
	
	
	
	
	 //써머노트 이미지 업로드
	 @RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	 @ResponseBody public String uploadSummernoteImageFile(@RequestParam("file")
	 MultipartFile multipartFile, HttpServletRequest request ) { JsonObject jsonObject = new JsonObject();
	 
	 
	  //String fileRoot = "D:\\upimg\\"; // 외부경로로 저장을 희망할때.
	 
	 
	 // 내부경로로 저장 
	 String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/"); 
	 String fileRoot = contextRoot+"resources/fileupload/";
	 
	 String originalFileName = multipartFile.getOriginalFilename(); //오리지날 파일명
	 String extension =
	 originalFileName.substring(originalFileName.lastIndexOf(".")); //파일 확장자
	 String savedFileName = UUID.randomUUID() + extension; //저장될 파일 명
	 
	 File targetFile = new File(fileRoot + savedFileName); try { InputStream
	 fileStream = multipartFile.getInputStream();
	 FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
	 jsonObject.addProperty("url","/resources/fileupload/"+savedFileName); //contextroot + resources + 저장할 내부 폴더명
	 jsonObject.addProperty("responseCode", "success");
	 
	 } catch (IOException e) { FileUtils.deleteQuietly(targetFile); //저장된 파일 삭제
	 jsonObject.addProperty("responseCode", "error"); e.printStackTrace(); }
	 String a = jsonObject.toString(); 
	 return a; }
	
	 
	 


}
