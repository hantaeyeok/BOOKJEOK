package com.kh.bookjeok.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.kh.bookjeok.notice.model.dao.NoticeRepository;
import com.kh.bookjeok.notice.model.vo.Notice;
import com.kh.bookjeok.notice.model.vo.NoticeFile;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

		private final NoticeRepository noticeRepository;
		private final SqlSessionTemplate sqlSession;
		
		@Override
		public int noticeCount() {
			return noticeRepository.noticeCount(sqlSession);
		}
		
		@Override
		public List<Notice> findAll(Map<String, Integer> map) {
			return noticeRepository.findAll(sqlSession, map);
		}
		
		@Override
		public int searchCount(Map<String, String> map) {
			return noticeRepository.searchCount(sqlSession, map);
		}
		
		@Override
		public List<Notice> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds) {
			return noticeRepository.findByConditionAndKeyword(sqlSession, map, rowBounds);
		}
		
		@Override
		public int insert(Notice notice) {
			return noticeRepository.insert(sqlSession, notice);
		}
		
		@Override
		public int increaseCount(int NoticeNo) {
			return noticeRepository.increaseCount(sqlSession, NoticeNo);
		}
		
		@Override
		public Notice findById(int noticeNo) {
			return noticeRepository.findById(sqlSession, noticeNo);
		}
		
		@Override
		public int delete(int boardNo) {
			return noticeRepository.delete(sqlSession, boardNo);
		}
		
		@Override
		public int update(Notice notice) {
			return noticeRepository.update(sqlSession, notice);
		}

		@Override
		public int update(NoticeFile noticeFile) {
			// TODO Auto-generated method stub
			return 0;
		}
	/*	
		@Override  (수정요망)
		public List<NoticeFile> selectNoticeFile() {
			return noticeRepository.selectNoticeFile(sqlSession);
		}
		
		@Override (수정요망)
		public NoticeFile updateNoticeFile(NoticeFile noticeFile) {
			return noticeRepository.updateNoticeFile(sqlSession, noticeFile);
		}*/
}