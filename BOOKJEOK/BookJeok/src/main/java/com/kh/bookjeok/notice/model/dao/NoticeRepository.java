package com.kh.bookjeok.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.bookjeok.notice.model.vo.Notice;
import com.kh.bookjeok.notice.model.vo.NoticeFile;

@Repository
public class NoticeRepository {

			public int noticeCount(SqlSessionTemplate sqlSession) {
				return sqlSession.selectOne("noticeMapper.noticeCount");
			}
			
			public List<Notice> findAll(SqlSessionTemplate sqlSession, Map<String, Integer> map) {
				return sqlSession.selectList("noticeMapper.findAll", map);
			}
			
			public int searchCount(SqlSessionTemplate sqlSession, Map<String, String> map) {
				return sqlSession.selectOne("noticeMapper.searchCount", map);
			}
			
			
			// RowBounds 이용 List 출력
			public List<Notice> findByConditionAndKeyword(SqlSessionTemplate sqlSession, Map<String, String> map,
					RowBounds rowBounds) {
				return sqlSession.selectList("noticeMapper.findByConditionAndKeyword", map, rowBounds);
			}
			
			// notice insert(글+첨부파일 업로드)
			public int insert(SqlSessionTemplate sqlSession, Notice notice) {
				return sqlSession.insert("noticeMapper.insert", notice);
			}
			
			// 조회 수 증가
			public int increaseNoticeVisited(SqlSessionTemplate sqlSession, int noticeNo) {
				return sqlSession.update("noticeMapper.increaseNoticeVisited", noticeNo);
			}
			
			// 조회 수 증가 후, 게시글 조회
			public Notice findById(SqlSessionTemplate sqlSession, int noticeNo) {
				return sqlSession.selectOne("noticeMapper.findById", noticeNo);
			}
			
			public int delete(SqlSessionTemplate sqlSession, int noticeNo) {
				return sqlSession.update("noticeMapper.delete", noticeNo);
			}
			
			public int update(SqlSessionTemplate sqlSession, Notice notice) {
				return sqlSession.update("noticeMapper.update", notice);
			}
			// 첨부파일 불러오기
			public List<NoticeFile> selectNoticeFile(SqlSessionTemplate sqlSession, int noticeNo) {
				return sqlSession.selectList("noticeMapper.selectNoticeFile", noticeNo);
			}
			// 첨부파일 업로드
			public int updateNoticeFile(SqlSessionTemplate sqlSession, NoticeFile noticeFile) {
				return sqlSession.update("noticeMapper.updatetNoticeFile", noticeFile);
			}

			public List<Notice> noticeList(SqlSessionTemplate sqlSession) {
				return sqlSession.selectList("noticeMapper.noticeList");
			}


}