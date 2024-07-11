package com.kh.bookjeok.book.model.service;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;

public interface BookService {

	int saveBook(Book book);
	int isbnCheck(String isbn);
	int saveBookDetail(BookDetail bookDetail);
	Book isbnSelect(String bookIsbn);
	Book selectBookNo(int bookNo);
}
