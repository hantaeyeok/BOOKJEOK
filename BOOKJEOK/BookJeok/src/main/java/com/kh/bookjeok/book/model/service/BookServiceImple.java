package com.kh.bookjeok.book.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.book.model.dao.BookMapper;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;
import com.kh.bookjeok.book.model.vo.BookReview;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
import com.kh.bookjeok.book.model.vo.ReviewAvg;
import com.kh.bookjeok.book.model.vo.TopCategory;
import com.kh.bookjeok.book.model.vo.UpperCategory;

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

	@Override
	public Book selectBookNo(int bookNo) {
		return bookMapper.selectBookNo(bookNo);
	}

	@Override
	public List<Book> keywrodByBook(String bookKeyword) {
		return bookMapper.keywrodByBook(bookKeyword);
	}

	@Override
	public List<TopCategory> topCategoryAll() {
		return bookMapper.topCategoryAll();
	}

	@Override
	public List<UpperCategory> upperCategoryBytopNo(Integer topCategoryNo) {
		return bookMapper.upperCategoryBytopNo(topCategoryNo);
	}

	@Override
	public List<MidCategory> midCategoryByupperNo(Integer upperCategoryNo) {
		return bookMapper.midCategoryByupperNo(upperCategoryNo);
	}

	@Override
	public List<LowerCategory> lowerCategoryBymidCategoryNo(Integer midCategory) {
		return bookMapper.lowerCategoryBymidCategoryNo(midCategory);
	}

	@Override
	public BookDetail selectBookDetailBybookNo(int bookNo) {
		return bookMapper.selectBookDetailBybookNo(bookNo);
	}

	@Override
	public List<BookReview> selectBookReviewBybookNo(int bookNo) {
		return bookMapper.selectBookReviewBybookNo(bookNo);
	}

	@Override
	public int saveReview(BookReview review) {
		return bookMapper.saveReview(review);
	}

	@Override
	public List<ReviewAvg> reviewAvg(int bookNo) {
		return bookMapper.reviewAvg(bookNo);
	}

	@Override
	public int countReviews(int bookNo) {
		return bookMapper.countReviews(bookNo);
	}

	@Override
	public List<BookReview> selectBookReviewByBookNo(Map<String, Object> params) {
		return bookMapper.selectBookReviewByBookNo(params);
	}

	@Override
	public int getBookPrice(int bookNo) {
		return bookMapper.getBookPrice(bookNo);
	}
	
	
	


	
}
