package com.kh.bookjeok.book.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale.Category;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("book")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService bookService;
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		  String originName = upfile.getOriginalFilename();
		  String ext = originName.substring(originName.lastIndexOf("."));
		  int num = (int)(Math.random() * 900) + 100;
		  String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		  String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		  String changeName = "KH_" + currentTime + "_" + num + ext;
		  
		  try {
			upfile.transferTo(new File(savePath + changeName));
		  } catch (IllegalStateException e) {
			  e.printStackTrace();
		  } catch (IOException e) {
			  e.printStackTrace();
		  }
		  
		  return "resources/uploadFiles/" + changeName;
	  }
	
	
	@GetMapping
	public String insertBook() {
		return "book/insertBook";
	}
	
	
	@PostMapping("/saveBook")
    public String saveBook(Book book, MultipartFile coverImg, String category ,HttpSession session) {		
		// 카테고리 데이터 : 어떻게 가공하냐. 
		/*
		국내도서>어린이>동화/명작/고전>외국창작동화
		국내도서>어린이>책읽기/글쓰기>글쓰기 일반
		국내도서>어린이>동화/명작/고전>외국창작동화
        */
		
		String[] categories = category.split(">");
		log.info("category data : {}",category);
		int categorySeq = 0;
		
		// 카테고리 데이터가 동일한게 있는지 확인해야한다.
		// 0 : 국내도서 1: 어린이 2 : 동화/명작/고전 3:외국창작동화
		// 동일한 카테고리가 있다면 그냥 등록,
		// 동일한 카테고리가 없다면 카테고리를 만들어서 넣어야함.
	
		//상위 카테고리 참조하려고 선언.
	    BookCategory parentCategory = null;
	    for (int i = 0; i < categories.length; i++) {
	    	// 현재 카테고리 이름과 상위 카테고리를 이용해서 카테고리가 있나 조회,
	        BookCategory currentCategory =  bookService.findCategoryNameParent(categories[i], parentCategory);
	        //조회된 카테고리 정보 로그 찍어봄.
	        log.info("cuurentCategory : {}",currentCategory);
	        
	        // 조회된 카테고리가 데이터베이스에 존재하지 않으면 새로 생성
	        if (currentCategory == null) {
	            currentCategory = new BookCategory();
	            
	            //카테고리에 객체에  해당 카테고리이름을 넣는다.
	            currentCategory.setCategoryName(categories[i]);
	            
	            //새 카테고리 객체의 상위 카테고리 번호를 설정
	            //상위 카테고리가 존재하면 그 번호를, 없으면 null을 사용
	            //여기 쳇지피티 찾아봄......ㅋㅋㅋㅋㅋ다시 공부.
	            currentCategory.setUpCategoryNo(parentCategory != null ? parentCategory.getCategoryNo() : null);
	            //currentCategory.setUpCategoryNo();
	            currentCategory.setCategorySeq(categorySeq++);  // 카테고리 순서를 설정하고 증가
	            
	            int result = bookService.saveCategory(currentCategory); 
	            if(result == 0) {
	            	log.info("category 실패");
	            } else {
	            	log.info("category 성공");
	            }
	        }  
	        parentCategory = currentCategory;  // 현재 카테고리를 부모 카테고리로 설정
	    }

	    // 카테고리 ID 설정
	    book.setCategoryId(parentCategory.getCategoryNo());
	    
	    //파일 이미지 커버 서버에저장
	    if(!coverImg.isEmpty()) {
	    	String coverPath = saveFile(coverImg, session);
	    	book.setBookCover(coverPath);
	    }
	    
	   
	    int result1 = bookService.saveBook(book);  // 책 정보를 데이터베이스에 저장
	    if(result1 == 0) {
	    	log.info("insertBook 실패");
	    } else {
	    	log.info("insertBook 성공");
	    }
	    
        return "redirect:/book";
    }

	
	//@PostMapping
	//public String saveBookDetail() {
		
	/* 데이터 들어가는 로직, 
    - 국내도서
    INSERT INTO BOOK_CATEGORY (CATEGORY_NAME, UP_CATEGORY_NO, CATEGORY_STATUS, CATEGORY_SEQ)
    VALUES ('국내도서', NULL, 'Y', 0);

    -- 어린이
    INSERT INTO BOOK_CATEGORY (CATEGORY_NAME, UP_CATEGORY_NO, CATEGORY_STATUS, CATEGORY_SEQ)
    VALUES ('어린이', (SELECT CATEGORY_NO FROM BOOK_CATEGORY WHERE CATEGORY_NAME = '국내도서'), 'Y', 1);

    -- 동화/명작/고전
    INSERT INTO BOOK_CATEGORY (CATEGORY_NAME, UP_CATEGORY_NO, CATEGORY_STATUS, CATEGORY_SEQ)
    VALUES ('동화/명작/고전', (SELECT CATEGORY_NO FROM BOOK_CATEGORY WHERE CATEGORY_NAME = '어린이'), 'Y', 2);

    -- 외국창작동화
    INSERT INTO BOOK_CATEGORY (CATEGORY_NAME, UP_CATEGORY_NO, CATEGORY_STATUS, CATEGORY_SEQ)
    VALUES ('외국창작동화', (SELECT CATEGORY_NO FROM BOOK_CATEGORY WHERE CATEGORY_NAME = '동화/명작/고전'), 'Y', 3);
    */
		
		
		
		

}
