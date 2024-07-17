package com.kh.bookjeok.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("notice")
public class NoticeForwardController {


	@GetMapping("listNotice")
	public String notice() {
		return "notice/listNotice";
	}

	@PostMapping("noticeInsert")
	public String noticeInsert() {
		return "notice/noticeInsert";
	}
	
	@PostMapping("noticeEdit")
	public String noticeEdit() {
		return "notice/noticeEdit";
	}
	
}