package com.kh.bookjeok.book.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookCategory {
	private String categoryNo;//1001
	private String categoryName;
	private String upCategoryNo;
    private String categoryStauts;
    private int categorySeq; 

}
