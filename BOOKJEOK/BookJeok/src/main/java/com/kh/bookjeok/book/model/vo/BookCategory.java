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
public class BookCategory {
    private String categoryNo; //카테고리 1000,1002, 등
    private String categoryName; // 카테고리 이름 국내도서,어린이,글쓰기, 일반 등
    private String upCategoryNo; // 카테고리 부모 번호
    private String categoryStatus; //카테고리 활성화 비활성화
    private int categorySeq;	//카테고리 깊이 1,2,3
    
}

//돌아가는 로직
/*

1. 카테고리

2.

3.

4.

*/