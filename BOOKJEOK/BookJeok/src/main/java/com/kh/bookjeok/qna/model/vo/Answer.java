package com.kh.bookjeok.qna.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class Answer {
	
	private int answerNo;
	private String answerContent;
	private Date answerDate;
	private Date answerEditdate;
	private String answerOriginname;
	private String answerChangename;
	private String answerStatus;
	private String userId;
	private int qnaNo;
	
}
