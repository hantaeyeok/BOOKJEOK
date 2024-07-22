package com.kh.bookjeok.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.member.model.vo.SocialMember;

@Service
public class KakaoService {
	public String getToken(String code) throws IOException, ParseException {
		// TODO Auto-generated method stub
		String tokenUrl = "https://kauth.kakao.com/oauth/token";
		URL url = new URL(tokenUrl);
		HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
		urlConnection.setRequestMethod("POST");
		urlConnection.setDoOutput(true);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()));
		
		StringBuilder sb = new StringBuilder();
		sb.append("client_id=7c415afe1c27d9e3c6d607c7ab634426");
		sb.append("&grant_type=authorization_code");
		sb.append("&redirect_uri=http://localhost/member/oauth");
		sb.append("&code=");
		sb.append(code);
		
		bw.write(sb.toString());
		bw.flush();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		
		String line = "";
		String responseData = "";
		while((line=br.readLine()) != null) {
			responseData+= line;
		}
		
		JSONParser parser= new JSONParser();
		JSONObject element = (JSONObject)parser.parse(responseData);
		
		String accessToken = element.get("access_token").toString();
		br.close();
		bw.close();
		return accessToken;
	}

	public void logout(String accessToken) throws IOException {
		// TODO Auto-generated method stub
		String logoutUrl="https://kapi.kakao.com/v1/user/logout";
		URL url = new URL(logoutUrl);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer "+accessToken);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String responseData = "";
		String line = "";
		while((line=br.readLine())!=null) {
			responseData+=line;
		}
	}
	
	public SocialMember getUserInfo(String accessToken) throws IOException, ParseException {
		String userInfoUrl="https://kapi.kakao.com/v2/user/me";
		URL url = new URL(userInfoUrl);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer "+accessToken);
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String responseData = br.readLine();
		
		JSONObject responseObj = (JSONObject)new JSONParser().parse(responseData); //responseData를 JSON형으로 변환한 responseObj
		JSONObject propObj = (JSONObject)responseObj.get("properties"); //responseObj 중 "properties"속성의 객체를 뽑아내서 다시 propObj로 집어넣음
		
		SocialMember sm = new SocialMember();
		sm.setId(responseObj.get("id").toString());
		sm.setNickName(propObj.get("nickname").toString());
		sm.setThumbnailImg(propObj.get("thumbnail_image").toString());
		return sm;
	}
}
