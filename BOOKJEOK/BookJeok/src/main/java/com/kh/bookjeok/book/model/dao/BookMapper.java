package com.kh.bookjeok.book.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

@Mapper
public interface BookMapper {
	
	//saveBook()
	public int saveBook(Book book, BookDetail bookdetail, BookCategory bookCategory);
	
	//insertBook()
	int insertBook(Book book);
	
	//insertBookDetail
	int insertBookDetail(BookDetail bookDetail);
	
	//insertBookCategory
	int insertBookCategory(BookCategory bookCategory);

}
