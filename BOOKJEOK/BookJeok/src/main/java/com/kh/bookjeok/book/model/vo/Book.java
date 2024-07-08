package com.kh.bookjeok.book.model.vo;

import java.sql.Date;
import java.util.List;

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
public class Book {
	private int bookNo;
	
	private String categoryId;
	
	private String bookTitle;
	private String bookAuthor;
	private String bookPublisher;
	private Date bookPubDate;
	private String bookIsbn;
	
	private int bookPrice;
	
	private String bookDescription;
	private String bookCover;
	private Date bookCreateDate;
	private Date bookUpdateDate;
	private Integer bookAmount;
	private String bookStatus;
	
}
