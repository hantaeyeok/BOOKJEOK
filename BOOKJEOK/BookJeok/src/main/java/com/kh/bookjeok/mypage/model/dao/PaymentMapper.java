package com.kh.bookjeok.mypage.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.mypage.model.vo.Payment;

@Mapper
public interface PaymentMapper {

	List<Payment> getAllOrderList(String userId);
	
	Payment getOrder(Payment payment);
	
	int insertPayment(Payment payment);
	
	int updatePayment(Payment payment);
	
	int deletePayment(Payment payment);
}
