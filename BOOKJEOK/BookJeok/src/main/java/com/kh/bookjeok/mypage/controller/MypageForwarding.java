package com.kh.bookjeok.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageForwarding {
	@GetMapping("/orderList")
	public String mypageOrderlist() {
		return "/mypage/orderList";
	}
	

}
