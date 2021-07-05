package com.spring.dao;

import java.util.List;

import com.spring.vo.BoardVO;
import com.spring.vo.Criteria;
import com.spring.vo.SearchCriteria;

public interface BoardDAO {

	//게시글 작성
	public int write(BoardVO boardVO) throws Exception; 

	//게시글 리스트
	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	
	//게시글 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	//게시글 읽기
	public BoardVO read(int bno) throws Exception;
	
	//게시글 수정
	public void update(BoardVO boardVO) throws Exception;
	
	//게시글 삭제
	public void delete(int bno) throws Exception;
	
	//조회수
	public void boardHit(int bno) throws Exception;
	
	
	
}
