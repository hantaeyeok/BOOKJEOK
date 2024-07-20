package com.kh.bookjeok.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;

import com.kh.bookjeok.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {

int noticeCount();

int increaseNoticeVisited(int noticeNo);

int insertNotice(Notice notice);

Notice findById(int noticeNo);




int updateNotice(Notice notice);

int deleteNotice(int noticeNo);

List<Notice> findAll(Map<String, Integer> map);



int searchCount(Map<String, String> map);

List<Notice> findByConditionAndKeyword(Map<String, String> map, RowBounds rowBounds);

int noticeCount(SqlSessionTemplate sqlSession);

int delete(int noticeNo);

List<Notice> noticeList();








}