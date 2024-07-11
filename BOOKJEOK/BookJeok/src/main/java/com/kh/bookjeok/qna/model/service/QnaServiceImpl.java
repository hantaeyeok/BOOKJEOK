package com.kh.bookjeok.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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

	@Override
	public List<Question> findAll(Map<String, Integer> map) {
		return qnaRepository.findAll(sqlSession, map);
	}

	@Override
	public int qnaCount() {
		return qnaRepository.qnaCount(sqlSession);
	}

	@Override
	public int searchCount(Map<String, String> map) {
		return qnaRepository.searchCount(sqlSession, map);
	}

	@Override
	public List<Question> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return qnaRepository.findByConditionAndKeyword(sqlSession, map, rowBounds);
	}

	
}
