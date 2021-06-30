package com.spring.dao;

import com.spring.vo.MemberVO;

public interface MemberDAO {
	
	//회원가입
	public void register(MemberVO vo) throws Exception;
	

}
