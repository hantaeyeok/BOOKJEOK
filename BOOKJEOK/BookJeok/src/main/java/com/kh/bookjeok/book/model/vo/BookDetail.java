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
    private int bookNo;
    private String detailImage;
    private String detailDescription;
}