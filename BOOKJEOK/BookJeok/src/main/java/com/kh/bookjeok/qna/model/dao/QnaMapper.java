package com.kh.bookjeok.qna.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.bookjeok.qna.model.vo.Question;

public class QnaMapper {

	public int insertQuestion(SqlSessionTemplate sqlSession, Question question) {
		return sqlSession.insert("qnaMapper.insert", question);
	}

}
