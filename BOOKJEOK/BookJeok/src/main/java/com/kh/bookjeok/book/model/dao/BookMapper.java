package com.kh.bookjeok.book.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookCategoryDetail;
import com.kh.bookjeok.book.model.vo.BookDetail;
import com.kh.bookjeok.book.model.vo.BookReview;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
import com.kh.bookjeok.book.model.vo.ReviewAvg;
import com.kh.bookjeok.book.model.vo.TopCategory;
import com.kh.bookjeok.book.model.vo.UpperCategory;

@Mapper
public interface BookMapper {
	
	// 카테고리를 검색하는 메소드
    TopCategory selectTopCategoryByName(String topCategoryName);
    UpperCategory selectUpperCategoryByNameAndParentId(Map<String, Object> upperParam);
    MidCategory selectMidCategoryByNameAndParentId(Map<String, Object> midParam);
    LowerCategory selectLowerCategoryByNameAndParentId(Map<String, Object> lowerParam);
	
	//카테고리 저장하는 메소드
	int insertTopCategory(TopCategory top);
	int insertUpperCategory(UpperCategory upper);
	int insertMidCategory(MidCategory mid);
	int insertLowerCategory(LowerCategory lower);
	
	
	//Book정보 저장하는 메소드
	int saveBook(Book book);
	int getBookPrice(int bookNo);
	
	//isbn
	int isbnCheck(String isbn);
	Book isbnSelect(String bookIsbn);
	
	//BookNo selectOne
	Book selectBookNo(int bookNo);
	
	//Book 키워드 검색
	List<Book> keywrodByBook(String bookKeyword);
	
	// 카테고리 list 검색
	List<TopCategory> topCategoryAll();
	List<UpperCategory> upperCategoryBytopNo(Integer topCategoryNo);
	List<MidCategory> midCategoryByupperNo(Integer upperCategoryNo);
	List<LowerCategory> lowerCategoryBymidCategoryNo(Integer midCategory);
	
	
	
	int saveBookDetail(BookDetail bookDetail);
	BookDetail selectBookDetailBybookNo(int bookNo);
	
	
	List<BookReview> selectBookReviewBybookNo(int bookNo);
	int saveReview(BookReview review);
	
	List<ReviewAvg> reviewAvg(int bookNo);
	int countReviews(int bookNo);
	
	List<BookReview> selectBookReviewByBookNo(Map<String, Object> params);
	
	List<Book> bookByKeyword(String keyword);
	
	List<BookCategoryDetail> bookCategoryDetail(String keyword);
	
}
