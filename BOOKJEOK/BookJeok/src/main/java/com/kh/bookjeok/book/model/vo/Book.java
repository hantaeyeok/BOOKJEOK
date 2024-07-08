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
public class Book {
	
	private int bookNO;
	private String categoryID;
	private String bookTitle;
	private String bookAuthor;
	private String bookPublisher;
	private Date bookPubDate;
	private String isbn;
	private int bookPrice;
	private String bookDescription; 
	private String cover; 
	private Date createDate;
	private Date updateDate;
	private String bookAmount;
	private String bookStatus;
	
}
