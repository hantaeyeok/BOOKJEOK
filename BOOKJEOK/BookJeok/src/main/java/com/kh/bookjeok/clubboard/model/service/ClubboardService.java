package com.kh.bookjeok.clubboard.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bookjeok.clubboard.model.vo.Clubboard;

public interface ClubboardService {

	int clubboardCount();

	List<Clubboard> findAllClubboard(Map<String, Integer> map);
	
	List<Clubboard> findByClubStatus(Map<String, Integer> map);

	int insertClubboard(Clubboard clubboard);
	
	int deleteClubboard(int clubboardNo);

	Clubboard findByNo(int clubboardNo);

}
