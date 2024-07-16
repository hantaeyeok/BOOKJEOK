package com.kh.bookjeok.mypage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.member.model.service.MemberServiceImp1;
import com.kh.bookjeok.member.model.vo.Member;
import com.kh.bookjeok.mypage.model.service.PaymentServiceImpl;
import com.kh.bookjeok.mypage.model.vo.Payment;
import com.kh.bookjeok.mypage.model.vo.PaymentPerbook;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {
	
	private final MemberServiceImp1 memberService;
	private final PaymentServiceImpl paymentService;
	@GetMapping("/orderList")
	public ModelAndView mypageOrderlist(HttpSession session, ModelAndView mv) {
		Member member = (Member)session.getAttribute("loginUser");
		if(member!=null && member.getUserId()!=null) {
			List<Payment> orderList = paymentService.getAllOrderList(member.getUserId());
			/*
			List<PaymentPerbook> orderListPerbook =  new ArrayList();
			for( Payment p : orderList ) {
				for(int i=0; i<p.getOrderList().size(); i++) {
					orderListPerbook.add(p.getOrderList().get(i));
				}
			}
			*/
			System.out.println(orderList);
			mv.addObject("orderList",orderList)
			  .setViewName("/mypage/orderList");
		} else {
			mv.setViewName("redirect:/");
		}
		
		return mv;
	}
	
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
