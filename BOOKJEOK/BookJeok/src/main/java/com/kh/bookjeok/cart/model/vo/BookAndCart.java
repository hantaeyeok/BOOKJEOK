package com.kh.bookjeok.cart.model.vo;

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
public class BookAndCart {

		private int bookNo;
		private Integer categoryId;
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
		private int bookAmount;
		private String bookStatus;
		private int cartNo;
		private String userId;
		private int cartTotal;
		private int cartAmount;
	
}
