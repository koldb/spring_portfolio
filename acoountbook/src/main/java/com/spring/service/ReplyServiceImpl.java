package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.ReplyDAO;
import com.spring.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Inject ReplyDAO dao;

	//댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}

	//댓글 입력
	@Override
	public int writeReply(ReplyVO vo) throws Exception {
		return dao.writeReply(vo);
	}

	//댓글 수정
	@Override
	public int updateReply(ReplyVO vo) throws Exception {
		return dao.updateReply(vo);
	}

	//댓글 삭제
	@Override
	public int deleteReply(int rno) throws Exception {
		return dao.deleteReply(rno);
	}

	/*
	 * //댓글 select
	 * 
	 * @Override public ReplyVO selectReply(int rno) throws Exception { return
	 * dao.selectReply(rno); }
	 */
	
	
	
	
}
