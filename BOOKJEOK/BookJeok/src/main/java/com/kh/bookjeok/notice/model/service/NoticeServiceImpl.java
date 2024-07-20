package com.kh.bookjeok.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.notice.model.dao.NoticeMapper;
import com.kh.bookjeok.notice.model.vo.Notice;
import com.kh.bookjeok.notice.model.vo.NoticeFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

		private final NoticeMapper noticeMapper;
		
		@Override
		public int noticeCount() {
			return noticeMapper.noticeCount();
		}
		
		@Override
		public List<Notice> findAll(Map<String, Integer> map) {
			return noticeMapper.findAll(map);
		}
		
		@Override
		public int searchCount(Map<String, String> map) {
			return noticeMapper.searchCount(map);
		}
		
		@Override
		public List<Notice> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
			return noticeMapper.findByConditionAndKeyword(map, rowBounds);
		}
		
		@Override
		public int insertNotice(Notice notice) {
			return noticeMapper.insertNotice(notice);
		}
		
		@Override
		public int increaseNoticeVisited(int NoticeNo) {
			return noticeMapper.increaseNoticeVisited(NoticeNo);
		}
		
		@Override
		public Notice findById(int noticeNo) {
			return noticeMapper.findById(noticeNo);
		}
		
		@Override
		public int deleteNotice(int noticeNo) {
			return noticeMapper.deleteNotice(noticeNo);
		}
		
		@Override
		public int updateNotice(Notice notice) {
			return noticeMapper.updateNotice(notice);
		}


		//test
		@Override
		public List<Notice> noticeList() {
			return noticeMapper.noticeList();
		}

		@Override
		public int updateNoticeFile(NoticeFile noticeFile) {
			return noticeMapper.updateNotice(noticeFile);

		}



		//@Override
		//public int update(NoticeFile noticeFile) {

		}
	/*	
		@Override  (수정요망)
		public List<NoticeFile> selectNoticeFile() {
			return noticeMapper.selectNoticeFile(sqlSession);
		}
		
		@Override (수정요망)
		public NoticeFile updateNoticeFile(NoticeFile noticeFile) {
			return noticeMapper.updateNoticeFile(sqlSession, noticeFile);
		}*/
