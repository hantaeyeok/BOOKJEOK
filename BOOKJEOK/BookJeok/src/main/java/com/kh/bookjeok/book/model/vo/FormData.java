package com.kh.bookjeok.book.model.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FormData {
	private String bookNo;
    private String bookCoverText;
    private MultipartFile bookCoverFile;
    private String bookTitle;
    private String bookAuthor;
    private String bookPublisher;
    private String bookPubDate;  // 만약 `Date`로 사용하고 싶다면, 변환 로직이 필요합니다.
    private String bookIsbn;
    private String topCategory;
    private String upperCategory;
    private String midCategory;
    private String lowerCategory;
    private String bookPrice;
    private String bookAmount;
    private String bookDescription;
    private String categoryString;
}



