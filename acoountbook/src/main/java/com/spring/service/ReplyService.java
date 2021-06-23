package com.spring.service;

import java.util.List;

import com.spring.vo.ReplyVO;

public interface ReplyService {

	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;
	
	//댓글 입력
	public int writeReply(ReplyVO vo) throws Exception;
	
	//댓글 수정
	public int updateReply(ReplyVO vo) throws Exception;
	
	//댓글 삭제
	public int deleteReply(int rno) throws Exception;
	
	/*
	 * //댓글 select public ReplyVO selectReply(int rno) throws Exception;
	 */
	
}
