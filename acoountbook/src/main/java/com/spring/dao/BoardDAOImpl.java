package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void writer(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMaper.insert", boardVO);
	}

}
