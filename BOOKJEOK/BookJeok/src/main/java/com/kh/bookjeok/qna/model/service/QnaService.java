package com.kh.bookjeok.qna.model.service;

import com.kh.bookjeok.qna.model.vo.Question;

public interface QnaService {

	int insertQuestion(Question question);

	Question findById(int qnaNo);

	int updateQuestion(Question question);

	int deleteQna(int qnaNo);

}
