package com.kh.bookjeok.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bookjeok.book.model.service.BookService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("book")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService bookService;
	
	@GetMapping
	public String insertBook() {
		return "book/insertBook";
	}
	
	@PostMapping
	public String saveBook() {
		bookService.saveBook(null, null, null)
		
		
		return "";
	}
	
}
