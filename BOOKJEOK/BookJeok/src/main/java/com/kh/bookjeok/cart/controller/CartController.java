package com.kh.bookjeok.cart.controller;

import java.util.ArrayList;
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

import com.kh.bookjeok.book.model.service.BookService;
import com.kh.bookjeok.book.model.vo.Book;
import com.kh.bookjeok.cart.model.service.CartService;
import com.kh.bookjeok.cart.model.vo.BookAndCart;
import com.kh.bookjeok.cart.model.vo.Cart;
import com.kh.bookjeok.common.model.vo.Message;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("cart")
@RequiredArgsConstructor
public class CartController {

	private final CartService cartService;
	private final BookService bookService;
	
	 @PostMapping("/add")
	 public ResponseEntity<Message> addToCart(@RequestParam int bookNo, 
	                                             @RequestParam int quantity, 
	                                             HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		String userId = null;
		
		if (loginUser != null) {
            userId = loginUser.getUserId();
        } else {
            userId = (String) session.getAttribute("tempUserId");
            if (userId == null) {
                userId = UUID.randomUUID().toString();
                session.setAttribute("tempUserId", userId);
            }
        }
        
        Map<String, Object> param = new HashMap<String, Object>();
        int bookPrice = bookService.getBookPrice(bookNo);
        int cartTotal = bookPrice * quantity;
        param.put("userId", userId);
        param.put("bookNo", bookNo);
        param.put("cartAmount", quantity);
        param.put("cartTotal", cartTotal);
        
        int result = cartService.addToCart(param);
       
        if (result > 0) {
        	return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("장바구니에 추가되었습니다.").build());
        } else {
        	return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("장바구니 추가 실패").build());
        }  
	}
	
	@GetMapping("list")
    public ResponseEntity<Message> getCartItems(HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		String userId = null;
		
		if (loginUser != null) {
			userId = loginUser.getUserId();
		} else {
			userId = (String) session.getAttribute("tempUserId");
		}
        
		/*
		for (Cart cartItem : cartItems) {
        int bookNo = cartItem.getBookNo();
        BookAndCart bookAndCart = cartService.bookAndCartByBookNo(userId, bookNo);
        bookAndCartList.add(bookAndCart);
    }
		 */
		
		List<Cart> cartItems = cartService.getCartItems(userId);
	    List<BookAndCart> bookAndCartList = new ArrayList<>();

	    for (int i = 0; i < cartItems.size(); i++) {
	        int bookNo = cartItems.get(i).getBookNo();
	        BookAndCart bookAndCart = cartService.bookAndCartByBookNo(userId, bookNo);
	        bookAndCartList.add(bookAndCart);
	    }

	    return ResponseEntity.status(HttpStatus.OK).body(Message.builder().data(bookAndCartList).build());
	}
	
	@PostMapping("updateQuantity")
	public ResponseEntity<Message> updateQuantity(@RequestParam int bookNo, @RequestParam int quantity, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        String userId = null;

        if (loginUser != null) {
            userId = loginUser.getUserId();
        } else {
            userId = (String) session.getAttribute("tempUserId");
        }
        if (userId == null) {
        	 return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("유저 정보가 없습니다.").build());
        }
        Map<String, Object> param = new HashMap<>();
        param.put("userId", userId);
        param.put("bookNo", bookNo);
        param.put("cartAmount", quantity);
        
        int result = cartService.updateCartQuantity(param);
        
        if (result > 0) {
            return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("장바구니 수량이 업데이트되었습니다.").build());
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("장바구니 수량 업데이트 실패").build());
        }
    }
	
	
	
	@PostMapping("delete")
	public ResponseEntity<Message> deleteFromCart(@RequestParam int bookNo, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		String userId = null;
		if (loginUser != null) {
			userId = loginUser.getUserId();
		} else {
			userId = (String) session.getAttribute("tempUserId");
		}
		
		int result = cartService.deleteCart(userId, bookNo);
		if (result > 0) {
			return ResponseEntity.status(HttpStatus.OK).body(Message.builder().message("장바구니에서 삭제되었습니다.").build());
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder().message("장바구니 삭제 실패").build());
		}	
	}
	
	/*
	@PostMapping("purchase")
    public ResponseEntity<Message> purchaseItems(HttpSession session) {
		 Member loginUser = (Member) session.getAttribute("loginUser");
		 String userId = null;
	
		 if (loginUser != null) {
			 userId = loginUser.getUserId();
		 } else {
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
	*/
	
}
