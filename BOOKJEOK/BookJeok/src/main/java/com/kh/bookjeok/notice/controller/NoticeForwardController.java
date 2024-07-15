package com.kh.bookjeok.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("notice")
public class NoticeForwardController {


	@GetMapping("noticeList")
	public String login() {
		return "notice/noticeList";
	}

}