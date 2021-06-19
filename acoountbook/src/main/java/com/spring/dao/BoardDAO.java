package com.spring.dao;

import com.spring.vo.BoardVO;

public interface BoardDAO {

	//게시글 작성
	public void writer(BoardVO boardVO) throws Exception; 
	
}
