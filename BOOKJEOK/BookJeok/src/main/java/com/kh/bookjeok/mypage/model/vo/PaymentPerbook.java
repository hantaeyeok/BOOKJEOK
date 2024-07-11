package com.kh.bookjeok.mypage.model.vo;

import com.kh.bookjeok.book.model.vo.Book;

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
public class PaymentPerbook {
	private String orderNo;
	private int bookNo;
	private int orderQuan;
	private Book book;
}
