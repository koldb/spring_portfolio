package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{

	@Inject SqlSession sql;
	
	//댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("replyMapper.readReply",bno);
	}

	//댓글 입력
	@Override
	public void writerReply(ReplyVO vo) throws Exception {
		sql.insert("replyMapper.writeReply",vo);
	}

}
