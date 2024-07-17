package com.kh.bookjeok.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("notice")
public class NoticeForwardController {


	@GetMapping("noticeList")
	public String notice() {
		return "notice/noticeList";
	}

	@PostMapping("noticeForm.do")
	public String noticeUpdate() {
		return "notice/noticeInsert";
	}
	
	@PostMapping("notice-update")
	public String noticeForm() {
		return "notice/noticeEdit";
	}
	
}