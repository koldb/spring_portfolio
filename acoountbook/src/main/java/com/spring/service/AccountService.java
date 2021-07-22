package com.spring.service;

import java.util.List;

import org.springframework.ui.Model;

import com.spring.vo.AccountVO;

public interface AccountService {

		//내역 읽어오기
		public List<AccountVO> accRead(AccountVO accountVO)throws Exception;
		
		//내역 입력
		public int accInsert(AccountVO accountVO) throws Exception;
		
		
		//내역 삭제
		public void accDelete(int accNum) throws Exception;
		
		//내역 수정
		public void accUpdate(AccountVO accountVO) throws Exception;


	
	
	
}
