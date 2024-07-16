package com.kh.bookjeok.clubboard.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.bookjeok.clubboard.model.dao.ClubboardMapper;
import com.kh.bookjeok.clubboard.model.vo.Clubboard;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClubboardServiceImpl implements ClubboardService {
	
	private final ClubboardMapper clubboardMapper;
	
	@Override
	public int clubboardCount() {
		return clubboardMapper.clubboardCount();
	}

	@Override
	public List<Clubboard> findAllClubboard(Map<String, Integer> map) {
		return clubboardMapper.findAllClubboard(map);
	}

	@Override
	public List<Clubboard> findByClubStatus(Map<String, Integer> map) {
		return clubboardMapper.findByClubStatus(map);
	}

	@Override
	public int insertClubboard(Clubboard clubboard) {
		return clubboardMapper.insertClubboard(clubboard);
	}

	@Override
	public int deleteClubboard(int clubboardNo) {
		return clubboardMapper.deleteClubboard(clubboardNo);
	}

	@Override
	public Clubboard findByNo(int clubboardNo) {
		return clubboardMapper.findByNo(clubboardNo);
	}
	
}
