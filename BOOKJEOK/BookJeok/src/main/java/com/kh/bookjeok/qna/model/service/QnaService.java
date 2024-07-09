package com.kh.bookjeok.qna.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookjeok.qna.model.vo.Question;

public interface QnaService {

	int insertQuestion(Question question);

	Question findById(int qnaNo);

	int updateQuestion(Question question);

	int deleteQna(int qnaNo);

	List<Question> findAll(Map<String, Integer> map);

	int qnaCount();

}
