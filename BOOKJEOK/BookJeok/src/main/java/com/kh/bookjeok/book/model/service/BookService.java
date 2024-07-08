package com.kh.bookjeok.book.model.service;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

public interface BookService {

	//saveBook()
	public int saveBook(Book book, BookDetail bookdetail, BookCategory bookCategory);
	
	//insertBook()
	int insertBook(Book book);
	
	//insertBookDetail
	int insertBookDetail(BookDetail bookDetail);
	
	//insertBookCategory
	int insertBookCategory(BookCategory bookCategory);
	
}
