package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.AccountVO;

@Repository
public class AccountDAOImpl implements AccountDAO{

	@Inject
	private SqlSession sqlSession;
	
	
	//내역 읽어오기
	@Override
	public List<AccountVO> accRead(AccountVO accountVO) throws Exception {
		return sqlSession.selectList("boardMapper.accRead",  accountVO);
	}
	
	//내역 입력
	@Override
	public int accInsert(AccountVO accountVO) throws Exception {
		return sqlSession.insert("boardMapper.accInsert", accountVO );
	}


	//내역 삭제
	@Override
	public void accDelete(int accNum) throws Exception {
		sqlSession.delete("boardMapper.accDelete", accNum);
	}

	//내역 수정
	@Override
	public void accUpdate(AccountVO accountVO) throws Exception {
		sqlSession.update("boardMapper.accUpdate", accountVO);
	}

	
	
}
