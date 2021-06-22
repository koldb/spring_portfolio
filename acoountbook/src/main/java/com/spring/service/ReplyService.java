package com.spring.service;

import java.util.List;

import com.spring.vo.ReplyVO;

public interface ReplyService {

	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;
	
	//댓글 입력
	public void writeReply(ReplyVO vo) throws Exception;
}
