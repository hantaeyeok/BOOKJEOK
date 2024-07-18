package com.kh.bookjeok.payment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("payment")
public class PaymentForwardController {


	@GetMapping("payOrder")
	public String payment() {
		return "payment/payment-procedure";
		
	}
	
	@GetMapping("payComplete")
	public String payCom() {
		return "payment/payment-completion";
		
	}
}