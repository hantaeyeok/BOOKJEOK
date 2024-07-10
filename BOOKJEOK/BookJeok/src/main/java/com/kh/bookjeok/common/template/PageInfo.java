package com.kh.bookjeok.common.template;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@Builder
@ToString
public class PageInfo {
	
	int listCount; //현재 일반 게시판의 게시글 총 개수 => Board테이블로부터 SELECT COUNT(*)활용해서 조회
	int currentPage;  // 현재 페이지(사용자가 요청한 페이지) => 앞에서 넘길 것
	int pageLimit; // 페이징 하단에 보여질 페이징바의 최대 개수 => 10개
	int boardLimit; // 한 페이지에 보여질 게시글의 최대 개수 => 10개
	
	int maxPage;  // 가장 마지막 페이지가 몇 번 페이지인지(총 페이지 개수)
	int startPage; // 페이지 하단에 보여질 페이징바의 시작 수
	int endPage; // 페이지 하단에 보여질 페이징바의 끝 수
	
    // 데이터베이스 쿼리 범위를 위한 필드 추가
    int startValue;
    int endValue;

    public static PageInfo getPageInfo(int listCount,int currentPage,int pageLimit,int boardLimit) {
		int maxPage = (int)Math.ceil((double)listCount/boardLimit);
		int startPage = (currentPage - 1)/ pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit -1;
		if(endPage > maxPage) endPage = maxPage;
		int startValue = (currentPage - 1) * boardLimit;
		int endValue = currentPage * boardLimit;
	
	return PageInfo.builder().pageLimit(pageLimit)
							 .startPage(startPage)
							 .endPage(endPage)
							 .listCount(listCount)
							 .currentPage(currentPage)
							 .maxPage(maxPage)
							 .boardLimit(boardLimit)
							 .startValue(startValue)
							 .endValue(endValue)
							 .build();
	}
}


/*
 public static PageInfo getPageInfo(int listCount,int currentPage,int pageLimit,int boardLimit)
 		방법 1
		int listCount = noticeService.noticeCount();
		int currentPage = page;
		int pageLimit = 10;
		int noticeLimit = 10;
	    PageInfo pageing = PageInfo.getPageInfo(listCount, currentPage, pageLimit, noticeLimit)
	    
		
		방법 2
		int searchCount = noticeService.searchCount(map);
		int currentPage = page;
		int pageLimit = 3;
		int noticeLimit = 3;
		PageInfo pageInfo = PageInfo.getPageInfo(searchCount, currentPage, pageLimit, noticeLimit);
		RowBounds rowBous = new RowBounds(pageInfo.getStartValue(),noticeLimit);
		List<Notice> noticeList = noticeService.findByConditionAndKeyword(map, rowBous);
		
		
 */




