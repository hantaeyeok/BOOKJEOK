package com.kh.bookjeok.book.model.service;

import java.util.List;

import com.kh.bookjeok.book.model.vo.Book;

public interface BookService {

	//insert
	int saveBook(Book book);
	
	//update
	int updateBook(Book book);
	
	//delete
	int deleteBook(int bookNo);
	
	//select(유효성 검사)
	int isbnCheck(String isbn);
	
	//select(도서 기본 정보 검색)
	List<Book> findAllBooks();
	
	//select(특정 도서 검색)
    Book findByBookNo(int bookNo);
	
	//select(카테고리 별 검색)
	List<Book> findBookByCategory(String categoryId);
	
	//select(책 제목, 책 저자로 검색)
	Book findByBookNo(String keyword);
	
	//select(베스트셀러 5 list)
	List<Book> bestBookTop5();
	
	//select(카테고리별 list)
	 List<Book> findBooksByCategory(String categoryId);
	
}
