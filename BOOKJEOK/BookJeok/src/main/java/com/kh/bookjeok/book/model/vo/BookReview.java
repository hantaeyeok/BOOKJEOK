package com.kh.bookjeok.book.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookReview {

	private int reviewNo;
	private String userId;
	private String orderNo;
	private int bookNo;
	private String reviewContext;
	private int reviewRating;
	private Date reviewCreateDate;
	private Date reviewUpdateDate;
	private String reviewStatus;
		
	
}
