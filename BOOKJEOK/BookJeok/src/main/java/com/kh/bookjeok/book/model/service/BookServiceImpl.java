package com.kh.bookjeok.book.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.book.model.dao.BookMapper;
import com.kh.bookjeok.book.model.vo.Book;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService{

	//private final BookMapper bookMapper;
	
	@Override
	public int saveBook(Book book) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBook(Book book) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBook(int bookNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int isbnCheck(String isbn) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Book> findAllBooks() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Book findByBookNo(int bookNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Book> findBookByCategory(String categoryId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Book findByBookNo(String keyword) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Book> bestBookTop5() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Book> findBooksByCategory(String categoryId) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
