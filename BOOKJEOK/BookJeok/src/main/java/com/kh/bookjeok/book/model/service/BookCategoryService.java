package com.kh.bookjeok.book.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bookjeok.book.model.dao.BookMapper;
import com.kh.bookjeok.book.model.vo.LowerCategory;
import com.kh.bookjeok.book.model.vo.MidCategory;
import com.kh.bookjeok.book.model.vo.TopCategory;
import com.kh.bookjeok.book.model.vo.UpperCategory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookCategoryService {

    private final BookMapper bookMapper;

    @Transactional
    public Integer saveCategory(String categoryString) {
    	
        String[] categoryLevels = categoryString.split(">");
        //국내도서>어린이>동화/명작/고전>책읽기/글쓰기
        
        Integer categoryId = null;
        Integer topNo =null, upperNo = null, midNo = null, lowerNo = null; 
        
        TopCategory top = bookMapper.selectTopCategoryByName(categoryLevels[0]);	//카테고리NAME이 같은 것이 있는지 SELECT해서 그 객체를 반환한다. //반환값이 널인경우 생성해야하며, //반환값이 NULL이 아닌경우 해당 TOP카테고리를 사용한다.
        if(top == null) {
        	TopCategory newTop = new TopCategory();
        	newTop.setTopCategoryName(categoryLevels[0]);
        	bookMapper.insertTopCategory(newTop);
        	newTop = bookMapper.selectTopCategoryByName(newTop.getTopCategoryName());
        	topNo = newTop.getTopCategoryNo();
        } else {
        	topNo = top.getTopCategoryNo();
        }
        
        
        Map<String, Object> upperParam = new HashMap<>();
        upperParam.put("upperCategoryName", categoryLevels[1]);
        upperParam.put("topCategoryNo", topNo);

        UpperCategory upper = bookMapper.selectUpperCategoryByNameAndParentId(upperParam);
        if(upper == null) {
        	UpperCategory newUpper = new UpperCategory();
        	newUpper.setUpperCategoryName(categoryLevels[1]);
        	newUpper.setTopCategoryNo(topNo);
        	bookMapper.insertUpperCategory(newUpper);
        	newUpper = bookMapper.selectUpperCategoryByNameAndParentId(upperParam);
        	upperNo = newUpper.getUpperCategoryNo();
        } else {
        	upperNo = upper.getUpperCategoryNo();
        }
        
        Map<String, Object> midParam = new HashMap<>();
        midParam.put("midCategoryName", categoryLevels[2]);
        midParam.put("upperCategoryNo", upperNo);
        
        MidCategory mid = bookMapper.selectMidCategoryByNameAndParentId(midParam);
        if (mid == null) {
            MidCategory newMid = new MidCategory();
            newMid.setMidCategoryName(categoryLevels[2]);
            newMid.setUpperCategoryNo(upperNo);
            bookMapper.insertMidCategory(newMid);
            newMid = bookMapper.selectMidCategoryByNameAndParentId(midParam);
            midNo = newMid.getMidCategoryNo();
        } else {
            midNo = mid.getMidCategoryNo();
        }
        
        
        if(categoryLevels.length == 4) {
	        Map<String, Object> lowerParam = new HashMap<>();
	        lowerParam.put("lowerCategoryName", categoryLevels[3]);
	        lowerParam.put("midCategoryNo", midNo);
	        
	        LowerCategory lower = bookMapper.selectLowerCategoryByNameAndParentId(lowerParam);
	        if (lower == null) {
	            LowerCategory newLower = new LowerCategory();
	            newLower.setLowerCategoryName(categoryLevels[3]);
	            newLower.setMidCategoryNo(midNo);
	            bookMapper.insertLowerCategory(newLower);
	            lower = bookMapper.selectLowerCategoryByNameAndParentId(lowerParam);
	            lowerNo = lower.getLowerCategoryNo();
	        } else if(categoryLevels[3] == null){
	        	log.info("categoryLevels[3] null");
	        } else {
	        	lowerNo = lower.getLowerCategoryNo();
	        }
        }
        
        if (lowerNo != null) {
            categoryId = lowerNo;
        } else {
            categoryId = midNo;
        }
	    
        return categoryId;
    }
    
    
    public String categoryPull() {
    	
    	
    	
    }
}
