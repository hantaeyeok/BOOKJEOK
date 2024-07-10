package com.kh.bookjeok.book.model.service;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
import com.kh.bookjeok.book.model.vo.TopCategory;
import com.kh.bookjeok.book.model.vo.UpperCategory;

public interface BookService {

	int saveBook(Book book);
	int isbnCheck(String isbn);
}
