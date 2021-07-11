package com.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.spi.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.service.BoardService;
import com.spring.service.ReplyService;
import com.spring.vo.ReplyVO;

@RestController
@RequestMapping(value = "/restBoard")
public class RestBoardController {

	private static final Logger logger = org.slf4j.LoggerFactory.getLogger(BoardController.class);

	@Inject
	private ReplyService replyService;

	// 댓글 리스트
	@RequestMapping(value = "/readReply", method = RequestMethod.POST)
	public List<ReplyVO> getReplyList(@RequestParam("bno") int bno  ) throws Exception {
		return replyService.readReply(bno);
	}

	// 댓글 입력
	@RequestMapping(value = "/writeReply", method = RequestMethod.POST)
	public Map<String, Object> writeReply(@RequestBody ReplyVO replyVO) throws Exception {
		Map<String, Object> result = new HashMap<>();

		try {
			replyService.writeReply(replyVO);
			System.out.println("ok");
			System.out.println(replyVO);
			result.put("status", "OK");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}

	// 댓글 수정
	@RequestMapping(value = "/updateReply", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> updateReply(@RequestBody ReplyVO replyVO) throws Exception {
		Map<String, Object> result = new HashMap<>();
		try {
			replyService.updateReply(replyVO);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}

//	// 댓글 삭제
//	@RequestMapping(value = "/deleteReply", method = { RequestMethod.GET, RequestMethod.POST })
//	public Map<String, Object> deleteReply(@RequestParam("rno") int rno) throws Exception {
//		Map<String, Object> result = new HashMap<>();
//		try {
//			replyService.deleteReply(rno);
//			result.put("status", "OK");
//
//		} catch (Exception e) {
//			e.printStackTrace();
//
//			result.put("status", "False");
//		}
//		return result;
//	}

}
