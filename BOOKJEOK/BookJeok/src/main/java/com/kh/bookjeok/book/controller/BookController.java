package com.kh.bookjeok.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;

import lombok.RequiredArgsConstructor;

@Controller
//@RequiredArgsConstructor
@RequestMapping("book")
public class BookController {
	
	//private final BookService bookservice;
	
	@GetMapping
	public String registerBook() {
		return "book/insertBook";
	}
	
	@PostMapping
	public String saveBook(Book book) {
		
		//int result = bookservice.saveBook(book);
		
		
		return "";
	}
	
	
}
