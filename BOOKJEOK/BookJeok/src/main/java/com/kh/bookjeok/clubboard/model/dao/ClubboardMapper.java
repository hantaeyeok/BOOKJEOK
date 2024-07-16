package com.kh.bookjeok.clubboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.bookjeok.clubboard.model.vo.Clubboard;

@Mapper
public interface ClubboardMapper {

	int clubboardCount();

	List<Clubboard> findAllClubboard(Map<String, Integer> map);
	
	List<Clubboard> findByClubStatus(Map<String, Integer> map);

	int insertClubboard(Clubboard clubboard);

	int deleteClubboard(int clubboardNo);

	Clubboard findByNo(int clubboardNo);

}
