package com.kh.bookjeok.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("member")
public class MemberForwarding {
	
	@GetMapping("loginform")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("joinform")
	public String join() {
		return "member/join";
	}
		

	
	@GetMapping("findId")
	public String findId() {
		return "member/findId";
	}
	
	@GetMapping("findPwd")
	public String findPwd() {
		return "member/findPwd";
	}
}
