package com.kh.bookjeok.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
			mv.addObject("orderList",orderList)
			  .setViewName("/mypage/orderList");
		} else {
			mv.setViewName("redirect:/");
		}
		return mv;
	}
	
	@GetMapping("/orderDetail")
	public ModelAndView orderDetail(Payment order, HttpSession session, ModelAndView mv) {
		Member member = (Member)session.getAttribute("loginUser");
		order.setUserId(((Member)session.getAttribute("loginUser")).getUserId());
		if(member!=null && member.getUserId()!=null) {
			order = paymentService.getOrder(order);
			int bookSumPrice = 0;
			for(PaymentPerbook p : order.getOrderList()) {
				bookSumPrice += p.getBook().getBookPrice()*p.getOrderQuan();
			}
			order.setBookSumPrice(bookSumPrice);
			mv.addObject("order",order)
			  .setViewName("/mypage/orderDetail");
		} else {
			mv.setViewName("redirect:/");
		}
		return mv;
	}
	
	
	@ResponseBody
	@PostMapping("/orderRefund")
	public String orderRefund(String orderNo, String refundForm) {
		String str = orderNo + " : " + refundForm;
		System.out.println(str);
		return str;
	}
	
	
}
