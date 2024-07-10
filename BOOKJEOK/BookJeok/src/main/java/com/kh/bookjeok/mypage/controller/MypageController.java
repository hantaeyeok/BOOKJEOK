package com.kh.bookjeok.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	//private final MemberServiceImp1 memberService;
	//private final PaymentServiceImp1 PaymentService;
	
	@GetMapping("/orderDetail")
	public String orderDetail(String orderNo, HttpSession session, Model model) {
		String returnPage="/mypage/orderDetail";
		model.addAttribute("orderNo",orderNo);
		// String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		// String userIdInput = orderService.getOrderByNo(orderNo).getUserId();
		// String returnPage (userId == userIdInput) ?  "/mypage/orderDetail" : "/common/errorPage"
		return returnPage;
	}
	
	
	@GetMapping("/orderRefund")
	public String orderRefund(String orderNo, HttpSession session) {
		String returnPage="/mypage/orderRefund";
		System.out.println(orderNo);
		// String userId = ((Member)session.getAttribute("loginUser")).getUserId();
		// String userIdInput = orderService.getOrderByNo(orderNo).getUserId();
		// String returnPage (userId == userIdInput) ?  "/mypage/orderDetail" : "/common/errorPage"
		return returnPage;
	}
	
}
