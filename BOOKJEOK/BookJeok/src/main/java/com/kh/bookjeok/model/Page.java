package com.kh.bookjeok.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@Builder
@ToString
@NoArgsConstructor
public class Page {
	
	int listCount; 		// 게시글 수
	int currentPage;	// 현재 페이지
	int pageLimit;		// 페이징 바(버튼)에 보여질 최대 개수
	int listLimit;		// 한 페이지에 보여질 게시글 최대 개수
	
	int maxPage;		// 총 페이지 개수
	int startPage;		// 페이징 바의 시작 수 
	int endPage;		// 페이징 바의 마지막 수
	
	int startValue;
	int endValue;
		
}
