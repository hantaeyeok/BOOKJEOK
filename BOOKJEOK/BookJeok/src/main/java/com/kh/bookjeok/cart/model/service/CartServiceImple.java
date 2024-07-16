package com.kh.bookjeok.cart.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.cart.model.dao.CartMapper;
import com.kh.bookjeok.cart.model.vo.BookAndCart;
import com.kh.bookjeok.cart.model.vo.Cart;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CartServiceImple implements CartService {

	private final CartMapper cartMapper;
	
	@Override
	public int addToCart(Map<String, Object> params) {
		return cartMapper.addToCart(params);
	}

	@Override
	public List<Cart> getCartItems(String userId) {
		return cartMapper.getCartItems(userId);
	}

	@Override
	public int mergeCart(String userId, String tempUserId) {
		return cartMapper.mergeCart(userId, tempUserId);
	}

	@Override
	public int deleteCart(String userId, int bookNo) {
		return cartMapper.deleteCart(userId, bookNo);
	}

	@Override
	public BookAndCart bookAndCartByBookNo(String userId, int bookNo) {
		return cartMapper.bookAndCartByBookNo(userId,bookNo);
	}

	@Override
	public int updateCartQuantity(Map<String, Object> param) {
		return cartMapper.updateCartQuantity(param);
	}

	
	
}
