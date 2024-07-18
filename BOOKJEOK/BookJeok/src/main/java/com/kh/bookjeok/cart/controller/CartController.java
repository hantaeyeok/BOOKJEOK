package com.kh.bookjeok.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.bookjeok.cart.model.service.CartService;
import com.kh.bookjeok.cart.model.vo.Cart;
import com.kh.bookjeok.common.model.vo.Message;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("cart")
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;
	
	 @PostMapping("/add")
	    public ResponseEntity<Message> addToCart(@RequestParam int bookNo, 
	                                             @RequestParam int quantity, 
	                                             HttpSession session) {
	        // 사용자 userId 가져온다.
	        String userId = (String) session.getAttribute("userId");
	        // userId가 없다면 임시 세션을 불른다.
	        if (userId == null) {
	            userId = (String) session.getAttribute("tempUserId");
	            // 그래도 없으면 새로운 userId 임시로 만든다.
	            if (userId == null) {
	                userId = UUID.randomUUID().toString();
	                session.setAttribute("tempUserId", userId);
	            }
	        }
	        
	        // 파라미터를 맵으로 저장
	        Map<String, Object> param = new HashMap<>();
	        param.put("userId", userId);
	        param.put("bookNo", bookNo);
	        param.put("quantity", quantity);
	        
	        
	        int bookPrice = bookService.getBookPrice(bookNo);
	        int cartTotal = bookPrice * quantity;
	        
	        param.put("cartTotal", cartTotal);
	        
	        int result = cartService.addToCart(param);
	        
	        if (result > 0) {
	            return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("장바구니에 추가되었습니다.").build());
	        } else {
	            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("장바구니 추가 실패").build());
	        }
	    }
	
	@GetMapping("list")
    public ResponseEntity<List<Cart>> getCartItems(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            userId = (String) session.getAttribute("tempUserId");
        }
        
        List<Cart> cartItems = cartService.getCartItems(userId);
        return ResponseEntity.status(HttpStatus.OK).body(cartItems);
    }
	
	
	@PostMapping("purchase")
    public ResponseEntity<Message> purchaseItems(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("로그인이 필요합니다.").build());
        }
        
        String tempUserId = (String) session.getAttribute("tempUserId");
        if (tempUserId != null) {
            cartService.mergeCart(userId, tempUserId);
            session.removeAttribute("tempUserId");
        }
        
        //여기는 구매 따로 구현해야함.
        return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("구매가 완료되었습니다.").build());

	}
        
	@PostMapping("delete")
	public ResponseEntity<Message> deleteFromCart(@RequestParam int bookNo, HttpSession session) {
	String userId = (String) session.getAttribute("userId");
		if (userId == null) {
			userId = (String) session.getAttribute("tempUserId");
		}
		
		int result = cartService.deleteCart(userId, bookNo);
		
		if (result > 0) {
			return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("장바구니에서 삭제되었습니다.").build());
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("장바구니 삭제 실패").build());
		}	
	}
	
	
	
	
	
	
}
