package com.kh.bookjeok.book.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("book")
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
		log.info("keyword : {}", keyword);
		
	
        
		
		return responseData;
	}
}
