package com.kh.bookjeok.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;


@Builder
@Getter
@Setter
@AllArgsConstructor
public class NoticeFile {

	private String noticeImgOriginName;
	private String noticeImgChangeName;
	private String noticeOriginName;
	private String noticeChangeName;

		
	}

