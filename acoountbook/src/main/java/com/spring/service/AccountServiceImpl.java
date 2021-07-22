package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.AccountDAO;
import com.spring.vo.AccountVO;

@Service
public class AccountServiceImpl implements AccountService{

	@Inject
	private AccountDAO dao;
	
	
	//카테고리 읽어오기
	@Override
	public List<AccountVO> accRead(AccountVO accountVO) throws Exception {
		return dao.accRead(accountVO);
	}

	//내역 입력
	@Override
	public int accInsert(AccountVO accountVO) throws Exception {
		return dao.accInsert(accountVO);
	}
	

	//내역 삭제
	@Override
	public void accDelete(int accNum) throws Exception {
		dao.accDelete(accNum);
	}

	//내역 수정
	@Override
	public void accUpdate(AccountVO accountVO) throws Exception {
		dao.accUpdate(accountVO);
	}

}
