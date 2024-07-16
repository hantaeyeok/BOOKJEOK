package com.kh.bookjeok.cart.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookjeok.cart.model.vo.Cart;

public interface CartService {

	int addToCart(Map<String,Object> param);

	List<Cart> getCartItems(String userId);

	int mergeCart(String userId, String tempUserId);

	int deleteCart(String userId, int bookNo);

}
