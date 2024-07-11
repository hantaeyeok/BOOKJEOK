package com.kh.bookjeok.book.controller;


import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.bookjeok.book.model.service.BookCategoryService;
import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;
import com.kh.bookjeok.common.model.FileUploadService;
import com.kh.bookjeok.common.model.vo.Message;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("books")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService bookService;
	private final FileUploadService fileUploadService;
	private final BookCategoryService bookCategoryService;
	
	@ResponseBody
	@GetMapping("/isbnCheck")
	public ResponseEntity<Message> isbnCheck(String isbn) {
		log.info("isbn : {}",isbn);
		int response = bookService.isbnCheck(isbn);
		if(response == 0) {
            Message responseMsg = Message.builder()
                                         .message("유효한 ISBN입니다.")
                                         .data("ISBN 유효성 검사 성공")
                                         .build();
            return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
        } else {
            Message responseMsg = Message.builder()
                                         .message("유효하지 않은 ISBN입니다.")
                                         .data("ISBN 유효성 검사 실패")
                                         .build();
            return ResponseEntity.status(HttpStatus.OK).body(responseMsg);
        }
		
	}
	
	@ResponseBody
	@PostMapping("/saveBook")
	public ResponseEntity<Message> saveBook(
	        Book book,
	        @RequestParam(required = false) String bookCoverText,
	        @RequestParam(required = false) MultipartFile bookCoverFile,
	        @RequestParam String categoryString,
	        HttpSession session) {
		
	if(bookCoverFile != null && !bookCoverFile.isEmpty()) { //파일로 들어올 때 
		String coverPath = fileUploadService.saveFile(bookCoverFile, session);
		book.setBookCover(coverPath);
	} else if (bookCoverText != null && !bookCoverText.isEmpty()) { // 경로로 들어올 때
		book.setBookCover(bookCoverText); 
	} else {
		log.info("북 커버가 없어서 기본 이미지 넣어요");
		book.setBookCover("bookbook.jpg");
	}
	        
	// 카테고리 저장 및 ID 반환
	Integer categoryId = bookCategoryService.saveCategory(categoryString);
	book.setCategoryId(categoryId);
	String bookIsbn = book.getBookIsbn();
	//saveBook
	int result = bookService.saveBook(book);
	if (result > 0) {
	    //도서 저장 성공 시, 도서 ID 반환
		Book newBook = bookService.isbnSelect(bookIsbn);

		Message responsMsg = Message.builder()
									.data(newBook.getBookNo())
									.message("도서 저장 성공")
									.build();
		return ResponseEntity.status(HttpStatus.OK).body(responsMsg);
	} else {
		return 	ResponseEntity.status(HttpStatus.OK).body(Message.builder()
																.message("도서 저장 실패")
																.build());
		}
	}
	
	@ResponseBody
	@PostMapping("/saveBookDetail")
	public ResponseEntity<Message> saveBookDetail(
				@RequestParam("bookNo") int bookNo,
				@RequestParam(required = false) MultipartFile detailImage,
				@RequestParam(required = false) String detailDescription,
				HttpSession session
				){
		//번호저장
		BookDetail bookDetail = new BookDetail();
		bookDetail.setBookNo(bookNo);
		
		//파일저장(null)
		if(detailImage != null && !detailImage.isEmpty() ) {
			String detailImagePath = fileUploadService.saveFile(detailImage, session);
			bookDetail.setDetailImage(detailImagePath);
		} else{
			log.info("북 커버가 없어서 기본 이미지 넣어요");
			bookDetail.setDetailImage("bookbook.jpg");
		}
		
		//설명 저장(null)허용
		if(detailDescription != null && !detailDescription.isEmpty()) {
			bookDetail.setDetailDescription(detailDescription);
		}
		
		
		int result = bookService.saveBookDetail(bookDetail);
		if(result > 0) {
			return ResponseEntity.status(HttpStatus.OK).body(Message.builder()
														.message("도서 상세정보 저장 성공")
														.build());
		} else {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
													.message("도서 상세정보 저장 실패")
													.build());
		}
	}
	
	public String category() {
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
