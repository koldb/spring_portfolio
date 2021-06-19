package com.spring.service;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.dao.BoardDAO;
import com.spring.vo.BoardVO;
@Service
public class BoardServiceImpl implements BoardService{

	@Inject
	private BoardDAO dao;
	
	@Override
	public void write(BoardVO boardVO) throws Exception {
		dao.writer(boardVO);
	}

}
