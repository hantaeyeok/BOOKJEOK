package com.kh.bookjeok.qna.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.bookjeok.qna.model.vo.Question;

public class QnaMapper {

	public int insertQuestion(SqlSessionTemplate sqlSession, Question question) {
		return sqlSession.insert("qnaMapper.insertQuestion", question);
	}

	public Question findById(SqlSessionTemplate sqlSession, int qnaNo) {
		return sqlSession.selectOne("qnaMapper.findById", qnaNo);
	}

	public int updateQuestion(SqlSessionTemplate sqlSession, Question question) {
		return sqlSession.update("qnaMapper.updateQuestion", question);
	}

	public int deleteQna(SqlSessionTemplate sqlSession, int qnaNo) {
		return sqlSession.update("qnaMapper.deleteQna", qnaNo);
	}

}
