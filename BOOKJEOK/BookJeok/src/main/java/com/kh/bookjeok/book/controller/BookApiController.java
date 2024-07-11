package com.kh.bookjeok.book.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("books")
public class BookApiController {

	@GetMapping(produces = "application/json; charset=UTF-8")
	public String searchAladinAPI(String keyword, String start) throws IOException {

		StringBuilder sb = new StringBuilder();
		String ttbkey = "ttbgksxodur11530001";
		int maxResults = 5;
		log.info(keyword);
		
		sb.append("http://www.aladin.co.kr/ttb/api/ItemSearch.aspx");
		sb.append("?ttbkey=");
		sb.append(ttbkey);
		sb.append("&Query=" + keyword);
		sb.append("&MaxResults=");
		sb.append(maxResults);
		sb.append("&start=");
		sb.append(start);
		sb.append("&SearchTarget=Book&output=xml&Version=20131101");
		
		log.info("url : {}",sb);
		System.out.println(sb);
		
		
		HttpURLConnection urlConnection = null;
		StringBuilder responseData = new StringBuilder();

		URL requestUrl = new URL(sb.toString());
		urlConnection = (HttpURLConnection) requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		String line;
		while ((line = br.readLine()) != null) {
		    responseData.append(line); 
	    }
		
	    // XML 응답을 JSON으로 변환 --> pom.xml org.json 라이브러리 추가 -> xml to json 파싱
	    JSONObject json = XML.toJSONObject(responseData.toString());
		log.info(responseData.toString());
		log.info("json ToString {}",json.toString());
		System.out.println(json.toString());
  	
		br.close();
	    urlConnection.disconnect();
	    
		return json.toString();
	}
}