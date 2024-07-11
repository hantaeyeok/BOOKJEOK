package com.kh.bookjeok.book.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.book.model.service.BookService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("book")
public class BookForwardController {

	private final BookService bookService;
	
	@GetMapping("/1")
	public String insertBook() {
		return "book/book-insert";
	}
	
	@GetMapping("/{bookNo}")
	public String updateBook(@PathVariable int bookNo, Model model) {
		model.addAttribute("book",bookService.selectBookNo(bookNo));
		return "book/book-update";
	}
	
	
}
