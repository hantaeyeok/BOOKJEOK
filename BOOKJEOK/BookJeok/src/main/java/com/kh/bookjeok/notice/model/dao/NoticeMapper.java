package com.kh.bookjeok.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookjeok.notice.model.vo.Notice;
//import com.kh.bookjeok.notice.model.vo.NoticeFile;

@Mapper
public interface NoticeMapper {

//글의 갯수	
int noticeCount();

//전체 글 찾기
Notice findById(int noticeNo);

List<Notice> findAll(Map<String, Integer> map);

//검색 관련글 갯수
int searchCount(Map<String, String> map);

//공지사항 글 조회수
int increaseNoticeVisited(int noticeNo);

int insertNotice(Notice notice);

int updateNotice(Notice notice);

//int updateNotice(NoticeFile noticeFile);

int deleteNotice(int noticeNo);






//검색 목록 조회
List<Notice> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);




//test
List<Notice> noticeList();









}