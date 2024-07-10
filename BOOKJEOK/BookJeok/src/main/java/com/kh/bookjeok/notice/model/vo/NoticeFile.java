package com.kh.bookjeok.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;


@Builder
@AllArgsConstructor
public class NoticeFile {
	private String userId;
	private String noticeImgOriginName;
	private String noticeImgChangeName;
	private String noticeOriginName;
	private String noticeChangeName;
}
