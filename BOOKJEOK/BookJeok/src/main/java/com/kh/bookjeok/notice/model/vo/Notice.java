package com.kh.bookjeok.notice.model.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class Notice {
	private int noticeNo;
	private String userId;
	private String noticeTitle;
	private String noticeContent;
	private int noticeVisited;
	private String noticeStatus;
	private Date noticeDate;
	private List<NoticeFile> noticeFileList;
	
}
