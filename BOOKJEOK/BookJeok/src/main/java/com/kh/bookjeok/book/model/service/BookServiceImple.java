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
	public int saveBook(Book book, BookDetail bookdetail, BookCategory bookCategory) {
		
		bookMapper.insertBook(book);
		bookMapper.insertBookDetail(bookdetail);
		bookMapper.insertBookCategory(bookCategory);
		
		int retult = bookMapper.saveBook(book, bookdetail, bookCategory);
		
		return retult;
	}

	@Override
	public int insertBook(Book book) {
		// TODO Auto-generated method stub
		return 0;
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

	

	
}
