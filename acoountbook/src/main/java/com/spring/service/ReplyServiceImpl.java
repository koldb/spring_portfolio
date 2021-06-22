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
	public void writeReply(ReplyVO vo) throws Exception {
		dao.writerReply(vo);
	}
	
	
	
	
}
