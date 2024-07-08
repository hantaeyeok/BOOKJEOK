package com.kh.bookjeok.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bookjeok.member.model.service.MemberService;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member")
public class MemberController {
	private final MemberService memberService;
	
	@PostMapping("login")
	public String login(Member member, HttpSession session) {
		Member loginUser;
		loginUser = memberService.login(member);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
		}
		System.out.println(session.getAttribute("loginUser"));
		return null;
	}
	
	@PostMapping("join")
	public String join(Member member, HttpSession session) {
		int nnn = memberService.insertMem(member);
		if (nnn > 0) {
			session.setAttribute("loginUser", member);
		}
		System.out.println(session.getAttribute("loginUser"));
		return null;
	}
}
