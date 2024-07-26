package com.kh.bookjeok.payment.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class PaymentAPIController {

	
	@Value("${imp.api.key}")
	private String apiKey;
	@Value("${imp.api.secretkey}")
	private String secretKey;

	

	@Construct
	public void init() {
		this.iamportClient = new IamportClient(apiKey, secretKey);
	}
}	
	
	/*	
		
		HttpRequest request = HttpRequest.newBuilder()
	    .uri(URI.create("https://api.iamport.kr/payments/imp_uid/balance"))
	    .header("Content-Type", "application/json")
	    .method("GET", HttpRequest.BodyPublishers.ofString("{}"))
	    .build();
	HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
	System.out.println(response.body());
		*/
		

	
	/*
		
		

		sb.append("http://www.");
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
	}*/
	
/*	}
}*/