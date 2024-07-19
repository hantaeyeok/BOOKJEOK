package com.kh.bookjeok.clubboard.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Clubboard {

	private int clubboardNo;
	private String clubboardTitle;
	private String bookclubName;
	private String clubboardContent;
	private String userId;
	private String clubboardOriginname;
	private String clubboardChangename;
	private String clubStatus;
	private int clubNumber;
	private Date clubPeriod;
	private int clubboardVisited;
	private Date clubboardDate;
	private String clubboardStatus;
}
