package com.kh.bookjeok.book.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.bookjeok.book.model.service.BookCategoryService;
import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.common.model.FileUploadService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("book")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService bookService;
	private final FileUploadService fileUploadService;
	private final BookCategoryService bookCategoryService;

	
	@GetMapping
	public String insertBook() {
		return "book/insertBook";
	}
	
	@PostMapping("/saveBook")
    public String saveBook(Book book, 
    		@RequestParam("bookCoverText") String bookCoverText,
    		String categoryString ,
    		HttpSession session) {		
		
		
	    
	    //파일 이미지 커버 서버에저장
	    //if(!coverImg.isEmpty()) {
	    	//String coverPath = fileUploadService.saveFile(coverImg, session);
	    	//book.setBookCover(coverPath);
	    	//
		//System.out.println(coverPath);
	    //} 
	    
	    System.out.println(bookCoverText);
	    book.setBookCover(bookCoverText);
	   
	 // 카테고리 저장 및 ID 반환
        Integer categoryId = bookCategoryService.saveCategory(categoryString);
        book.setCategoryId(categoryId);
	    
	    //saveBook
	    int result1 = bookService.saveBook(book);
	    if(result1 == 0) {
	    	log.info("insertBook 실패");
	    } else {
	    	log.info("insertBook 성공");
	    }
	    
	    return "redirect:/";
    }
	

		
}
