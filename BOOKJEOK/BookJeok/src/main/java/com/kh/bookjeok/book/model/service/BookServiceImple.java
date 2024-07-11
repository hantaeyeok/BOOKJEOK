package com.kh.bookjeok.book.model.service;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.book.model.dao.BookMapper;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookServiceImple implements BookService{

	private final BookMapper bookMapper;

	@Override
	public int saveBook(Book book) {
		return bookMapper.saveBook(book);
	}

	@Override
	public int isbnCheck(String isbn) {
		return bookMapper.isbnCheck(isbn);
	}

	@Override
	public int saveBookDetail(BookDetail bookDetail) {
		return bookMapper.saveBookDetail(bookDetail);
	}

	@Override
	public Book isbnSelect(String bookIsbn) {
		return bookMapper.isbnSelect(bookIsbn);
	}
	
	


	
}
