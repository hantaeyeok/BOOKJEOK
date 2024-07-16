package com.kh.bookjeok.cart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("cart")
public class CartFowrdController {

	@GetMapping("cartList")
	public String CartList() {
		return "cart/cart-cartList";
	}
}
