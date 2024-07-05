package com.kh.bookjeok.book.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class BookController {

	@GetMapping
	public String searchAladinAPI(String keyword) {
		
		StringBuilder sb = new StringBuilder();
		String ttbkey = "ttbgksxodur11530001";
		int maxResults = 10;
		
		sb.append("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx");
		sb.append("?ttbkey=");
		sb.append(ttbkey);
		sb.append("&Query=" + keyword);
		sb.append("&MaxResults=");
		sb.append(maxResults);
		sb.append("&start=1&SearchTarget=Book&output=xml&Version=20131101");
		
		log.info("url : {}",sb);
		/*
        http://www.aladin.co.kr/ttb/api/ItemSearch.aspx
        ?ttbkey=ttbgksxodur11530001
        &Query=${encodeURIComponent($keyword)}
        &QueryType=Keyword
        		&MaxResults=10
        		&start=1
        		&SearchTarget=Book&output=xml
        		&Version=20131101`,
		*/
		
		return "";
	}
}
