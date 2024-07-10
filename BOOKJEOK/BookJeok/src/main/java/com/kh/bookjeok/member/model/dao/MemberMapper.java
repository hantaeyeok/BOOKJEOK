package com.kh.bookjeok.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.member.model.vo.Member;

@Mapper
public interface MemberMapper{
	
	Member login(Member member);
	
	int insertMem(Member member);
	
	int update(Member member);
	
	int delete(String string);
	
	// 아이디 중복체크(SELECT)
	int idCheck(String idCheck);
	
}