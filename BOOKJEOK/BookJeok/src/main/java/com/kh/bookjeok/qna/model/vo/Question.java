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
public class Question {
	
	private int qnaNo;
	private String questionTitle;
	private String questionContent;
	private Date questionDate;
	private Date questionEditdate;
	private String questionOriginname;
	private String questionChangename;
	private String questionStatus;
	private String userId;
	
}
