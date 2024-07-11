package com.kh.bookjeok.member.model.service;

import com.kh.bookjeok.member.model.vo.Member;




public interface MemberService {
	
	Member login(Member member);
	
	int insertMem(Member member);
	
	int update(Member member);
	
	int updatePwd(Member member);
	int updatePhone(Member member);
	int updateEmail(Member member);
	int updateGender(Member member);
	int updateAddress(Member member);
	
	int delete(String string);
	
	// 아이디 중복체크(SELECT)
	int idCheck(String idCheck);
	int emailCheck(String emailCheck);

	
}
