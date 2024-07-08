package com.kh.bookjeok.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ForwardController {

	@GetMapping("books")
	public String registerBook() {
		return "book/insertBook";
	}
}
