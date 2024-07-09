package com.kh.bookjeok.notice.model.service;

import java.util.List;

import com.kh.bookjeok.notice.model.dao.NoticeMapper;
import com.kh.bookjeok.notice.model.vo.Notice;

public class NoticeServiceImpl implements NoticeService {
	private final NoticeMapper noticeMapper;

	@Override
	public List<Notice> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Notice findById(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int save(Notice notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Notice notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int noticeNo) {
		// TODO Auto-generated method stub
		return 0;
	}
}
