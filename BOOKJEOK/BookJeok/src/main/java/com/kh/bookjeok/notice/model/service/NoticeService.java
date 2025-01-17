package com.kh.bookjeok.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.kh.bookjeok.notice.model.vo.Notice;
//import com.kh.bookjeok.notice.model.vo.NoticeFile;

public interface NoticeService {

			int noticeCount();
			
			List<Notice> findAll(Map<String, Integer> map);
			
			// 게시글 검색 기능
			int searchCount(Map<String, String> map);
			
			// 검색 목록 조회
			List<Notice> findByConditionAndKeyword(Map<String,String> map, RowBounds rowBounds);
			
			// 게시글 작성
			int insertNotice(Notice notice);
			
			// 조회수 증가
			int increaseNoticeVisited(int NoticeNo);
			
			// 상세조회
			Notice findById(int noticeNo);
			
			// 게시글 삭제하기
			int deleteNotice(int noticedNo);
			
			// 게시글 수정하기
			//int updateNoticeFile(NoticeFile noticeFile);

			int updateNotice(Notice notice);

			//test
			List<Notice> noticeList();



			
}