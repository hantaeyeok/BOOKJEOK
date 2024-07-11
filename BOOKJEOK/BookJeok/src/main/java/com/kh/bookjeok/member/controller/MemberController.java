package com.kh.bookjeok.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.member.model.service.MemberService;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member")
public class MemberController {
	private final MemberService memberService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@PostMapping("login")
	public String login(Member member, HttpSession session) {
		Member loginUser;
		loginUser = memberService.login(member);
		
		if (loginUser!=null && bCryptPasswordEncoder.matches(member.getUserPwd(), loginUser.getUserPwd())) { 
			session.setAttribute("loginUser", loginUser);
			System.out.println("로그인 성공 - session객체 loginUser : "+ session.getAttribute("loginUser"));
			System.out.println();
		} else {
			System.out.println("로그인 실패");
		}
		
		return "redirect:/";
	}
	
	@PostMapping("join")
	public String join(Member member, HttpSession session) {

		member.setUserId(member.getUserId().replaceAll(" ", ""));
		member.setUserName(member.getUserName().replaceAll(" ", ""));
		member.setUserPwd(member.getUserPwd().replaceAll(" ", ""));
		member.setPhone(member.getPhone().replaceAll(" ", ""));
		member.setAddress(member.getAddress().replaceAll("  ", " "));
		member.setPostnum(member.getPostnum().replaceAll(" ", ""));
		member.setEmail(member.getEmail().replaceAll(" ", ""));
		
		//암호화구문 삽입 부분
		String encPwd = bCryptPasswordEncoder.encode(member.getUserPwd());
		member.setUserPwd(encPwd);
		System.out.println("member.getUserPwd encode버전 : " + member.getUserPwd());

		//DB 삽입구문
		int nnn = memberService.insertMem(member);
		//DB 삽입 성공시
		if (nnn > 0) {
			session.setAttribute("loginUser", member);
			System.out.println("회원가입 성공 - session객체 loginUser : " + session.getAttribute("loginUser"));
		} else {
			System.out.println("회원가입 실패");
		}
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("idCheck")
	public String userIdCheck(String checkId) {
		return memberService.idCheck(checkId) > 0 ? "NNNNN" : "NNNNY";
	}

	@ResponseBody
	@GetMapping("emailCheck")
	public String userEmailCheck(String checkEmail) {
		return memberService.emailCheck(checkEmail) > 0 ? "NNNNN" : "NNNNY";
	}
	
	@PostMapping("EditMemberPwCheck")
	public ModelAndView EditMemberPwCheck(String userPwd, HttpSession session, ModelAndView mv) {
		userPwd = userPwd.replaceAll(" ", "");
		Member loginUser;
		loginUser = (Member)session.getAttribute("loginUser");
		if (loginUser!=null && bCryptPasswordEncoder.matches(userPwd, loginUser.getUserPwd())) {
			mv.addObject("PassEncryptPasscheck","OK");
			mv.setViewName("/member/EditMemberInfo");
		} else {
			System.out.println("비밀번호 일치하지않음");
		}
		return mv;
	}
	
	@ResponseBody
	@PostMapping("EditMemberInfoPwd")
	public Member EditMemberInfoPwd(Member member, HttpSession session) {
		member.setUserId(member.getUserId().replaceAll(" ", ""));
		member.setUserPwd(member.getUserPwd().replaceAll(" ", ""));
		if(session.getAttribute("loginUser")!=null && member.getUserId().equals(  memberService.login(  (Member)(session.getAttribute("loginUser"))  ).getUserId())  ) {
			String encPwd = bCryptPasswordEncoder.encode(member.getUserPwd());
			System.out.println("member.getUserPwd() : "+member.getUserPwd());
			member.setUserPwd(encPwd);
			System.out.println("인코딩 후 member.getUserPwd() : " + member.getUserPwd());

			int up = memberService.updatePwd(member);
			member=memberService.login(member);
			if (up > 0) {
				System.out.println("업데이트 성공 - member : "+member);
			}
		}
		return member;
	}
	
	@ResponseBody
	@PostMapping("EditMemberInfoEtc")
	public Member EditMemberInfoEtc(Member member, HttpSession session) {
		member.setPhone(member.getPhone().replaceAll(" ", ""));
		member.setAddress(member.getAddress().replaceAll("  ", " "));
		member.setPostnum(member.getPostnum().replaceAll(" ", ""));
		member.setEmail(member.getEmail().replaceAll(" ", ""));
		System.out.println(member);
		if(session.getAttribute("loginUser")!=null && member.getUserId().equals(  memberService.login(  (Member)(session.getAttribute("loginUser"))  ).getUserId())  ) {
			int upAddress=0;
			int upPhone=0;
			int upGender=0;
			int upEmail=0;
			if (!member.getAddress().isEmpty())				{
				upAddress = memberService.updateAddress(member);
			}
			if (!member.getPhone().isEmpty())				{
				upPhone = memberService.updatePhone(member);
			}
			if (!member.getGender().isEmpty())				{
				upGender = memberService.updateGender(member);
			}
			if (!member.getEmail().isEmpty())				{
				upEmail = memberService.updateEmail(member);
			}
			member = memberService.login(member);
			session.setAttribute("loginUser", member);
			
			int rst = upAddress + upPhone + upGender + upEmail;
			if (rst > 0) {
				System.out.println("업데이트 성공 - member : "+ member);
			} else {
				System.out.println("없데이트");
			}
		}
		
		return member;
	}
	
	
}
