package com.kh.bookjeok.template;

import com.kh.bookjeok.model.Page;

public class PageTemplate {
	
	public static Page getPageInfo(int listCount,
			   int currentPage,
			   int pageLimit,
			   int listLimit) {

		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) endPage = maxPage;
		
		return Page.builder().pageLimit(pageLimit)
				   .startPage(startPage)
				   .endPage(endPage)
				   .listCount(listCount)
				   .currentPage(currentPage)
				   .maxPage(maxPage)
				   .listLimit(listLimit)
				   .build();
	}
}
