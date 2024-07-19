package com.kh.bookjeok.qna.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.bookjeok.qna.model.vo.Answer;
import com.kh.bookjeok.qna.model.vo.Question;

public interface QnaService {

	int insertQuestion(Question question);

	Question findById(int qnaNo);

	int updateQuestion(Question question);

	int deleteQna(int qnaNo);

	List<Question> findAll(Map<String, Integer> map);

	int qnaCount();

	int searchCount(Map<String, String> map);

	List<Question> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

	// 답변 
	
	int insertAnswer(Answer answer);

	Answer findAnswerByQnaNo(int qnaNo);

	List<Answer> findAllAnswer(Map<String, Integer> map);

	int deleteAnswer(int answerNo);

	Answer findByAnswerNo(int answerNo);

	int updateAnswer(Answer answer);

}
