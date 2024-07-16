package com.kh.bookjeok.book.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import com.kh.bookjeok.book.model.service.BookService;


import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("book")
@RequiredArgsConstructor
public class BookForwardController {
	//book-insert
	//bookjeok/book/1
	
	private final BookService bookService;
	
	@GetMapping("1")
	public String insertBook() {
		return "book/book-insert";
	}
	
	@GetMapping("2")
	public String insertBook2() {
		return "book/book-insert2";
	}
	
	@GetMapping("{bookNo}")
	public String getBookNo(@PathVariable int bookNo, Model model) {
		model.addAttribute("book",bookService.selectBookNo(bookNo));
		model.addAttribute("bookDetail",bookService.selectBookDetailBybookNo(bookNo));
		model.addAttribute("bookReview",bookService.selectBookReviewBybookNo(bookNo));
		return "book/book-getBookNo";
	}
}
