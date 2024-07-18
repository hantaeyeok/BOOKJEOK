package com.kh.bookjeok.mypage.model.service;

import java.util.List;

import com.kh.bookjeok.mypage.model.vo.Payment;

public interface PaymentService {
	
	List<Payment> getAllOrderList(String userId);
	
	Payment getOrder(Payment payment);
	
	int insertPayment(Payment payment);
	
	int updatePayment(Payment payment);
	
	int deletePayment(Payment payment);
}
