package com.kh.bookjeok.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("book")
public class BookController {
	
	@GetMapping
	public String insertBook() {
		return "book/insertBook";
	}
	
	@PostMapping
	public String saveBook() {
		
		
		
		return "";
	}
	
}
