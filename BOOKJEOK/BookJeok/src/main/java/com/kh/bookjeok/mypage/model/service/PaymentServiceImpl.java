package com.kh.bookjeok.mypage.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.mypage.model.dao.PaymentMapper;
import com.kh.bookjeok.mypage.model.vo.Payment;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class PaymentServiceImpl implements PaymentService{

	private final PaymentMapper paymentMapper;
	@Override
	public List<Payment> getAllOrderList(String userId) {
		// TODO Auto-generated method stub
		return paymentMapper.getAllOrderList(userId);
	}

	@Override
	public Payment getOrder(Payment payment) {
		// TODO Auto-generated method stub
		return paymentMapper.getOrder(payment);
	}

	@Override
	public int insertPayment(Payment payment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updatePayment(Payment payment) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePayment(Payment payment) {
		// TODO Auto-generated method stub
		return 0;
	}

}
