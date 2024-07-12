package com.kh.bookjeok.book.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.book.model.vo.BookDetail;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
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
	
	//isbnCheck
	int isbnCheck(String isbn);
	
	//
	int saveBookDetail(BookDetail bookDetail);
	
	//isbnSelect
	Book isbnSelect(String bookIsbn);
	
	//BookNo selectOne
	Book selectBookNo(int bookNo);
	
	
	List<Book> keywrodByBook(String bookKeyword);
	List<UpperCategory> upperCategoryBytopNo(Integer topCategoryNo);
	List<TopCategory> topCategoryAll();
	List<MidCategory> midCategoryByupperNo(Integer upperCategoryNo);
	List<LowerCategory> lowerCategoryBymidCategoryNo(Integer midCategory);
	
}
