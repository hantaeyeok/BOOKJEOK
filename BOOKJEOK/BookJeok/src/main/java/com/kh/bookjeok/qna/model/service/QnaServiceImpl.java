package com.kh.bookjeok.qna.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.qna.model.dao.QnaMapper;
import com.kh.bookjeok.qna.model.vo.Question;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {
	
	private final QnaMapper qnaMapper;
	private final SqlSessionTemplate sqlSession;

	@Override
	public int insertQuestion(Question question) {
		return qnaMapper.insertQuestion(sqlSession, question);
	}

	
}
