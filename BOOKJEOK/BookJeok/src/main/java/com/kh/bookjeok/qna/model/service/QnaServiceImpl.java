package com.kh.bookjeok.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.qna.model.dao.QnaMapper;
import com.kh.bookjeok.qna.model.vo.Answer;
import com.kh.bookjeok.qna.model.vo.Question;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService {
	
	private final QnaMapper qnaMapper;

	@Override
	public int insertQuestion(Question question) {
		return qnaMapper.insertQuestion(question);
	}

	@Override
	public Question findById(int qnaNo) {
		return qnaMapper.findById(qnaNo);
	}

	@Override
	public int updateQuestion(Question question) {
		return qnaMapper.updateQuestion(question);
	}

	@Override
	public int deleteQna(int qnaNo) {
		return qnaMapper.deleteQna(qnaNo);
	}

	@Override
	public List<Question> findAll(Map<String, Integer> map) {
		return qnaMapper.findAll(map);
	}

	@Override
	public int qnaCount() {
		return qnaMapper.qnaCount();
	}

	@Override
	public int searchCount(Map<String, String> map) {
		return qnaMapper.searchCount(map);
	}

	@Override
	public List<Question> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
		return qnaMapper.findByConditionAndKeyword(map, rowBounds);
	}

	// 답변
	
	@Override
	public int insertAnswer(Answer answer) {
		return qnaMapper.insertAnswer(answer);
	}

	@Override
	public Answer findAnswerByQnaNo(int qnaNo) {
		return qnaMapper.findAnswerByQnaNo(qnaNo);
	}

	@Override
	public List<Answer> findAllAnswer(Map<String, Integer> map) {
		return qnaMapper.findAllAnswer(map);
	}

	@Override
	public int deleteAnswer(int answerNo) {
		return qnaMapper.deleteAnswer(answerNo);
	}

	@Override
	public Answer findByAnswerNo(int answerNo) {
		return qnaMapper.findByAnswerNo(answerNo);
	}

	@Override
	public int updateAnswer(Answer answer) {
		return qnaMapper.updateAnswer(answer);
	}
	
}
