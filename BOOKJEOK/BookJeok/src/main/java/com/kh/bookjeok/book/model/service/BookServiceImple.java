package com.kh.bookjeok.book.model.service;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.book.model.dao.BookMapper;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategory;
import com.kh.bookjeok.book.model.vo.BookDetail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookServiceImple implements BookService{

	private final BookMapper bookMapper;
	
	@Override
	public int saveBookAll(Book book, BookDetail bookdetail, BookCategory bookCategory) {

		return 0;
	}

	@Override
	public int saveBook(Book book) {
		return bookMapper.saveBook(book);
	}

	@Override
	public int insertBookDetail(BookDetail bookDetail) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertBookCategory(BookCategory bookCategory) {
		// TODO Auto-generated method stub
		return 0;
	}

	//카테고리 
	@Override
	public BookCategory findCategoryNameParent(String categoryName, BookCategory parentCategory) {
		return bookMapper.findCategoryNameParent(categoryName, parentCategory);
	}

	@Override
	public int saveCategory(BookCategory category) {
		return bookMapper.saveCategory(category);
	}

	


	
}
