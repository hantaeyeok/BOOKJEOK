package com.kh.bookjeok.cart.model.vo;


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
public class Cart {
	
	private int cartNo;
	private int bookNo;
	private String userId;
	private int cartTotal;
	private int cartAmount;

}
