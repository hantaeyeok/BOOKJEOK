package com.kh.bookjeok.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.bookjeok.member.model.service.MemberService;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member")
public class MemberController {
	private final MemberService memberService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@PostMapping("login")
	public String login(Member member, HttpSession session) {
		Member loginUser;
		loginUser = memberService.login(member);
		
		if (loginUser!=null && bCryptPasswordEncoder.matches(member.getUserPwd(), loginUser.getUserPwd())) { 
			session.setAttribute("loginUser", loginUser);
			System.out.println("로그인 성공 - session객체 loginUser : "+ session.getAttribute("loginUser"));
			System.out.println();
		} else {
			System.out.println("로그인 실패");
		}
		
		return null;
	}
	
	@PostMapping("join")
	public String join(Member member, HttpSession session) {

		//암호화구문 삽입 부분
		String encPwd = bCryptPasswordEncoder.encode(member.getUserPwd());
		member.setUserPwd(encPwd);
		System.out.println("member.getUserPwd encode버전 : " + member.getUserPwd());

		//DB 삽입구문
		int nnn = memberService.insertMem(member);
		//DB 삽입 성공시
		if (nnn > 0) {
			session.setAttribute("loginUser", member);
			System.out.println("회원가입 성공 - session객체 loginUser : " + session.getAttribute("loginUser"));
		} else {
			System.out.println("회원가입 실패");
		}
		return null;
	}
	
	@ResponseBody
	@GetMapping("idCheck")
	public String userId(String checkId) {
		return memberService.idCheck(checkId) > 0 ? "NNNNN" : "NNNNY";
	}
	
}
