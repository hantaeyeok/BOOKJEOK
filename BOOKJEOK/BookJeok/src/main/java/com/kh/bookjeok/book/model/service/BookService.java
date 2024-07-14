package com.kh.bookjeok.book.model.service;

import java.util.List;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;
import com.kh.bookjeok.book.model.vo.BookReview;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
import com.kh.bookjeok.book.model.vo.ReviewAvg;
import com.kh.bookjeok.book.model.vo.TopCategory;
import com.kh.bookjeok.book.model.vo.UpperCategory;

public interface BookService {

	int saveBook(Book book);
	int isbnCheck(String isbn);
	int saveBookDetail(BookDetail bookDetail);
	Book isbnSelect(String bookIsbn);
	Book selectBookNo(int bookNo);
	
	
	List<Book> keywrodByBook(String bookKeyword);
	List<TopCategory> topCategoryAll();
	List<UpperCategory> upperCategoryBytopNo(Integer topCategoryNo);
	List<MidCategory> midCategoryByupperNo(Integer upperCategoryNo);
	List<LowerCategory> lowerCategoryBymidCategoryNo(Integer midCategory);
	
	BookDetail selectBookDetailBybookNo(int bookNo);
	List<BookReview> selectBookReviewBybookNo(int bookNo);
	
	int saveReview(BookReview review);
	List<ReviewAvg> reviewAvg(int bookNo);
}
