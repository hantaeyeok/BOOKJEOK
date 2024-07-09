package com.kh.bookjeok.book.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

@Mapper
public interface BookMapper {
	
	//saveBook()
	public int saveBookAll(Book book, BookDetail bookdetail, BookCategory bookCategory);
	
	//saveBook
	int saveBook(Book book);
	
	//insertBook()
	int insertBook(Book book);
	
	//insertBookDetail
	int insertBookDetail(BookDetail bookDetail);
	
	//insertBookCategory
	int insertBookCategory(BookCategory bookCategory);
	
	
	// 카테고리 상위 카테고리랑 비교하려고 함.
	BookCategory findCategoryNameParent(String categoryName, BookCategory parentCategory);
		
		
	// 카테고리 넣기,
	int saveCategory(BookCategory category);

}
