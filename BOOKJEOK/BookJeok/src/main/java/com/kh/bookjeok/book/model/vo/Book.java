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
	private Long bookNo;
	private String categoryId;
	private String bookTitle;
	private String bookAuthor;
	private String bookPublisher;
	private Date bookPubDate;
	private String bookIsbn;
	private Double bookPrice;
	private String bookDescription;
	private String bookCover;
	private Date bookCreateDate;
	private Date bookUpdateDate;
	private Integer bookAmount;
	private String bookStatus;
	
	// 카테고리 목록 - 도서가 여러 카테고리에 속할 수 있다고 가정할 때
    private List<BookCategory> categories;

    // 상세 정보 목록 - 도서에 여러 상세 정보가 있을 수 있다면
    private List<BookDetail> details;
}
