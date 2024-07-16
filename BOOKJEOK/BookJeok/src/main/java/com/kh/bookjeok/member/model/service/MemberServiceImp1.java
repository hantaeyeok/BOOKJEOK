package com.kh.bookjeok.member.model.service;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.member.model.dao.MemberMapper;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImp1 implements MemberService{

	private final MemberMapper memberMapper;
	
	@Override
	public Member login(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.login(member);
	}

	
	@Override
	public int insertMem(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.insertMem(member);
	}

	@Override
	public int update(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int updatePwd(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.updatePwd(member);
	}
	
	@Override
	public int delete(String string) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int idCheck(String idCheck) {
		// TODO Auto-generated method stub
		return memberMapper.idCheck(idCheck);
	}
	@Override
	public int emailCheck(String emailCheck) {
		// TODO Auto-generated method stub
		return memberMapper.emailCheck(emailCheck);
	}


	@Override
	public int updatePhone(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.updatePhone(member);
	}


	@Override
	public int updateEmail(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.updateEmail(member);
	}


	@Override
	public int updateGender(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.updateGender(member);
	}


	@Override
	public int updateAddress(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.updateAddress(member);
	}


	@Override
	public Member getMemberByEmail(Member member) {
		// TODO Auto-generated method stub
		return memberMapper.getMemberByEmail(member);
	}







}
