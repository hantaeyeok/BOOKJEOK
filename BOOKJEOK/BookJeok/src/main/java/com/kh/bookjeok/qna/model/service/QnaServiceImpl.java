package com.kh.bookjeok.qna.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.qna.model.dao.QnaRepository;
import com.kh.bookjeok.qna.model.vo.Question;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {
	
	private final QnaRepository qnaRepository;
	private final SqlSessionTemplate sqlSession;

	@Override
	public int insertQuestion(Question question) {
		return qnaRepository.insertQuestion(sqlSession, question);
	}

	@Override
	public Question findById(int qnaNo) {
		return qnaRepository.findById(sqlSession, qnaNo);
	}

	@Override
	public int updateQuestion(Question question) {
		return qnaRepository.updateQuestion(sqlSession, question);
	}

	@Override
	public int deleteQna(int qnaNo) {
		return qnaRepository.deleteQna(sqlSession, qnaNo);
	}

	
}
