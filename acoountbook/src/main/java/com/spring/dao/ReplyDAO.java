package com.spring.dao;

import java.util.List;

import com.spring.vo.ReplyVO;

public interface ReplyDAO {

	//댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;

	//댓글 작성
	public void writerReply(ReplyVO vo) throws Exception;
	
}
