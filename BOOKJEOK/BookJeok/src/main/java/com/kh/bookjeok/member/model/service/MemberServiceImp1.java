package com.kh.bookjeok.member.model.service;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.member.model.dao.MemberMapper;
import com.kh.bookjeok.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImp1 implements MemberService{

	private final MemberMapper MemberMapper;
	
	@Override
	public Member login(Member member) {
		// TODO Auto-generated method stub
		return MemberMapper.login(member);
	}

	
	@Override
	public int insertMem(Member member) {
		// TODO Auto-generated method stub
		return MemberMapper.insertMem(member);
	}

	@Override
	public int update(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int updatePwd(Member member) {
		// TODO Auto-generated method stub
		return MemberMapper.updatePwd(member);
	}
	
	@Override
	public int updateEtc(Member member) {
		// TODO Auto-generated method stub
		return MemberMapper.updateEtc(member);
	}

	@Override
	public int delete(String string) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int idCheck(String idCheck) {
		// TODO Auto-generated method stub
		return MemberMapper.idCheck(idCheck);
	}
	@Override
	public int emailCheck(String emailCheck) {
		// TODO Auto-generated method stub
		return MemberMapper.emailCheck(emailCheck);
	}







}
