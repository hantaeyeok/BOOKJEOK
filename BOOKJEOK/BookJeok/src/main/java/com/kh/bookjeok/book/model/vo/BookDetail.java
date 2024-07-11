package com.kh.bookjeok.book.model.vo;


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
public class BookDetail {
    private int detailNo;
    private Book bookNo; // 외래키 참조로 객체를 사용
    private String detailImage;
    private String detailDescription;
}