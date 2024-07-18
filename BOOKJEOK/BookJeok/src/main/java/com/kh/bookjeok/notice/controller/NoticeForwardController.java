package com.kh.bookjeok.notice.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bookjeok.notice.model.service.NoticeService;
import com.kh.bookjeok.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("notice")
@RequiredArgsConstructor
public class NoticeForwardController {
	
	private final NoticeService noticeService;

	//@GetMapping("listNotice")
	//public String notice() {
	//	return "notice/listNotice";
	//}
	
	@GetMapping("1")
   public String nogigi(Model model) {
	   List<Notice> notitiList = noticeService.noticeList();
	   model.addAttribute("noticeList", notitiList);
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