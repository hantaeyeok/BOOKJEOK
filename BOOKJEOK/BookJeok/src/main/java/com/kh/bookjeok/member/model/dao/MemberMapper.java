package com.kh.bookjeok.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.member.model.vo.Member;
import com.kh.bookjeok.member.model.vo.PwResetKey;

@Mapper
public interface MemberMapper{
	
	Member login(Member member);
	
	int insertMem(Member member);
	
	int update(Member member);
	
	int updatePwd(Member member);
	
	int updatePhone(Member member);
	int updateEmail(Member member);
	int updateGender(Member member);
	int updateAddress(Member member);
	int insertPhone(Member member);
	int insertEmail(Member member);
	int insertGender(Member member);
	int insertAddress(Member member);
	
	int delete(String string);
	
	// 아이디 중복체크(SELECT)
	int idCheck(String idCheck);
	int emailCheck(String emailCheck);

	Member getMemberByEmail(Member member);

	int pwdResetKeyInsert(PwResetKey pwResetKey);

	PwResetKey pwdResetKeySelectOne(PwResetKey pwResetKey);

	int pwdResetKeyDelete(PwResetKey pwResetKey);

	
}
