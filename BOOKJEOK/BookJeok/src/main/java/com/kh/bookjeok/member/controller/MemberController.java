package com.kh.bookjeok.member.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.common.model.Message;
import com.kh.bookjeok.member.model.service.KakaoService;
import com.kh.bookjeok.member.model.service.MemberService;
import com.kh.bookjeok.member.model.vo.Member;
import com.kh.bookjeok.member.model.vo.PwResetKey;
import com.kh.bookjeok.member.model.vo.SocialMember;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("member")
public class MemberController {
	private final MemberService memberService;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private KakaoService kakaoService;
	
	
	@ResponseBody
	@GetMapping("/oauth")
	public void socialLogin(HttpSession session, String code, ModelAndView mv) throws IOException, ParseException {
		if(session.getAttribute("loginUser")==null) {
			String accessToken = kakaoService.getToken(code);
			session.setAttribute("accessToken", accessToken);
			
			SocialMember sm = kakaoService.getUserInfo(accessToken);
			Member socialMember = Member.builder()
					.userId(sm.getId())
					.userName(sm.getNickName())
					.userPwd(bCryptPasswordEncoder.encode(sm.getId()+sm.getNickName()+sm.getThumbnailImg()))
					.email("example"+sm.getId()+"@gmail.com")
					.build();
					//비밀번호 : 소셜 사용자의 경우 마이페이지 정보수정 등에서도 비밀번호 재확인을 물어보지 않고 그냥 넘어가므로, 임의의 
					//이메일부분은 카카오에서 사업허가 등을 받고 카카오 이메일을 받아올 수 있게 된다면 그 이메일을 넣게 될 것이고, 현재는 임시 데이터를 집어넣었음 
			Member memberDB = memberService.login(socialMember);
			if (memberDB != null) {
				session.setAttribute("loginUser", memberDB);
				session.setAttribute("socialMember", "kakao");
			} else {
				int nnn = memberService.insertMem(socialMember);
				if(nnn > 0) {
					session.setAttribute("loginUser", socialMember);
					session.setAttribute("socialMember", "kakao");
				} else {
					System.out.println("소셜로그인-가입 실패");
				}
			}
		} else {
			System.out.println("이미 로그인되어있습니다");
		}
		
	}
	
	@ResponseBody
	@PostMapping("findId")
	public ResponseEntity<Message> findId(Member member) {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(message, false, "UTF-8");
	
			Member memberFind=memberService.getMemberByEmail(member);
			if (memberFind!=null && member.getUserName().equals(memberFind.getUserName())) {
				helper.setSubject("북적북적 - 아이디 찾기");
				helper.setText("<h1>아이디 찾기</h1><p>회원님의 아이디는</p><h3>"+memberFind.getUserId()+"</h3><p>입니다.</p>",true);
				helper.setTo(memberFind.getEmail());
				sender.send(message);
				return ResponseEntity.status(HttpStatus.OK).body(Message.builder()
																		.data("success")
																	    .message("데이터 전송완료")
																	    .build());
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																				 .data("fail")
																			     .message("데이터 전송실패")
																			     .build());
			}
		} catch (MessagingException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
															    .data("fail")
															    .message("이메일 전송실패")
															    .build());
			}
	}
	
	@ResponseBody
	@PostMapping("findPwd")
	public ResponseEntity<Message> findPwd(Member member){
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(message, false, "UTF-8");
			Member memberFind=memberService.getMemberByEmail(member);
			if (memberFind!=null && member.getUserId().equals(memberFind.getUserId())) {
				String code = bCryptPasswordEncoder.encode(memberFind.getUserName());
				PwResetKey pwResetKey = PwResetKey.builder()
												  .userId(memberFind.getUserId())
												  .code(code)
												  .build();
				int i = memberService.pwdResetKeyInsert(pwResetKey);
				if (i>0) {
					String link = "http://localhost/member/pwdreset?id="+memberFind.getUserId()+"&key="+code;
					helper.setSubject("북적북적 - 비밀번호 재설정");
					helper.setText("<h1>비밀번호 재설정</h1><h3>"+memberFind.getUserId()+"</h3>님<br/><p>아래 링크로 접속하셔서 비밀번호를 재설정해주세요.</p><br/>"+ link +"<br/><p>절대 타인과 이 링크를 공유하지 마세요!</p>" ,true);
					helper.setTo(memberFind.getEmail());
					sender.send(message);
					return ResponseEntity.status(HttpStatus.OK).body(Message.builder()
																			.data("success")
																		    .message("데이터 전송완료")
																		    .build());
				} else {
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																		 .data("fail")
																	     .message("비밀번호 재설정 코드 등록 실패")
																	     .build());
				}
				

			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																				 .data("fail")
																			     .message("데이터 전송실패")
																			     .build());
			}
		} catch (MessagingException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
																.data("fail")
															    .message("이메일 전송실패")
															    .build());
		}
	}
	
	@GetMapping("pwdreset")
	public ModelAndView pwdreset(String id, String key, ModelAndView mv) {
		PwResetKey pwResetKey = PwResetKey.builder().userId(id).code(key).build();
		Member member = memberService.login(Member.builder().userId(pwResetKey.getUserId()).build());
		if( pwResetKey!=null && memberService.pwdResetKeySelectOne(pwResetKey).getCode().equals(pwResetKey.getCode())  ) {
			if( member!=null && bCryptPasswordEncoder.matches(member.getUserName(), pwResetKey.getCode()) ) {
				mv.addObject("member",member)
				  .addObject("pwResetKey",pwResetKey)
				  .setViewName("/member/findPwd_reset");
			} else {
				mv.setViewName("redirect:/");
			}
		} else {
			mv.setViewName("redirect:/");
		}
		return mv;
	}
	
	@ResponseBody
	@PostMapping("pwdresetPro")
	public ResponseEntity<Message> pwdresetPro(Member member, String code) {
		PwResetKey pwResetKey = memberService.pwdResetKeySelectOne( PwResetKey.builder().userId(member.getUserId()).code(code).build() );
		member.setUserPwd( bCryptPasswordEncoder.encode(member.getUserPwd().replaceAll(" ", "")) );
		if(member!=null && pwResetKey.getCode().equals(code)) {
			int i = memberService.pwdResetKeyDelete(pwResetKey);
			int j = memberService.updatePwd(member);
			if (i>0) {
				if (j>0) {
					return ResponseEntity.status(HttpStatus.OK).body(Message.builder()
							.data("success")
						    .message("데이터 전송완료")
						    .build());
				} else {
					System.out.println("memberService.updatePwd 실패");
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
							.data("fail")
						    .message("memberService.updatePwd 실패")
						    .build());
				}
			} else {
				System.out.println("memberService.pwdResetKeyDelete 실패");
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
						.data("fail")
					    .message("memberService.pwdResetKeyDelete 실패")
					    .build());
			}
		}
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Message.builder()
				.data("fail")
			    .message("member이 null 이거나 pwResetKey가 DB와 일치하지않습니다.")
			    .build());
	}
	
	@GetMapping("logout")
	public String logout(Member member, HttpSession session) throws IOException {
		if (session.getAttribute("accessToken")!=null) {
			kakaoService.logout((String)session.getAttribute("accessToken"));
		}
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
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

		//DB 삽입구문
		int nnn = memberService.insertMem(member);
		//DB 삽입 성공시
		if (nnn > 0) {
			session.setAttribute("loginUser", member);
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
	
	@GetMapping("editMemberInfoBfr")
	public ModelAndView editMemberInfoBfr(HttpSession session, ModelAndView mv) {
		if (session.getAttribute("socialMember") != null) { //소셜로그인 사용자의 경우 그냥 바로 수정창으로 넘어감
			mv.addObject("PassEncryptPasscheck","OK")
			  .setViewName("/member/EditMemberInfo");
		} else {
			mv.setViewName("member/EditMemberInfoBfr");
		}
		return mv;
		
	}
}
