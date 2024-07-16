package com.kh.bookjeok.cart.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.bookjeok.cart.model.vo.BookAndCart;
import com.kh.bookjeok.cart.model.vo.Cart;

@Mapper
public interface CartMapper {

	int addToCart(Map<String, Object> params);
	List<Cart> getCartItems(String userId);
	int mergeCart(String userId, String tempUserId);
	int deleteCart(@Param("userId")String userId, @Param("bookNo") int bookNo);
	BookAndCart bookAndCartByBookNo(@Param("userId")String userId, @Param("bookNo") int bookNo);
	int updateCartQuantity(Map<String, Object> param);
}
