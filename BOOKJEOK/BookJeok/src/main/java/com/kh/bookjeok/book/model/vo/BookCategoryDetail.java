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
public class BookCategoryDetail {

	private int bookNo;
    private Integer categoryId;
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookPubDate;
    private String bookIsbn;
    private int bookPrice;
    private String bookDescription;
    private String bookCover;
    private Date bookCreateDate;
    private Date bookUpdateDate;

    private String topCategoryName;
    private String upperCategoryName;
    private String midCategoryName;
    private String lowerCategoryName;
    
    private int bookAmount;
    private String bookStatus;
	private int detailNo;
    private String detailImage;
    private String detailDescription;

}
