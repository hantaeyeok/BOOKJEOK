package com.kh.bookjeok.book.model.service;

import java.util.Map;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

public interface BookService {

	//saveBook()
	int saveBookAll(Book book, BookDetail bookdetail, BookCategory bookCategory);
	
	//saveBook
	int saveBook(Book book);
	
	//insertBookDetail
	int insertBookDetail(BookDetail bookDetail);
	
	//insertBookCategory
	int insertBookCategory(BookCategory bookCategory);
	
	//list 카테고리 구조 생성

	
	
	// 카테고리
	BookCategory findCategoryNameParent(String categoryName, BookCategory parentCategory);
	
	
	
	// 카테고리 넣기,
    int saveCategory(BookCategory category);

	
	
}
