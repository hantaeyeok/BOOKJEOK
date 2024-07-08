package com.kh.bookjeok.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

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
	public String saveBook(@ModelAttribute Book book, @ModelAttribute BookCategory bookCategory, @ModelAttribute BookDetail bookDetail, MultipartFile file) {
 
		
		bookDetail.setDetailImage();
	        
		bookService.saveBook(book, bookCategory, bookDetail);    
		return "";
	}
	
}
