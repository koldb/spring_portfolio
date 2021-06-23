package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.spring.dao.BoardDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.Criteria;
import com.spring.vo.SearchCriteria;
@Service
public class BoardServiceImpl implements BoardService{

	@Inject
	private BoardDAO dao;
	
	//게시글 작성
	@Override
	public int write(BoardVO boardVO) throws Exception {
		return dao.write(boardVO);
	}

	//게시글 리스트
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		return dao.list(scri);
	}
	
	//게시글 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return dao.listCount(scri);
	}

	//게시글 읽기
	@Override
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}

	//게시글 수정
	@Override
	public void update(BoardVO boardVO) throws Exception {
		dao.update(boardVO);
	}

	@Override
	public void delete(int bno) throws Exception {
		dao.delete(bno);
	}

	
}
