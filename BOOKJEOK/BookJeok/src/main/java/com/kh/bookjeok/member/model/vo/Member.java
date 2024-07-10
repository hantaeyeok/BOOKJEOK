package com.kh.bookjeok.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
	private String userId;
	private String userPwd;
	private String userName;
	private String enrollDate;
	private String modifyDate;
	private String status;
	private int mileage;
	private String phone;
	private String gender;
	private String address;
	private String addressDetail;
	private String postnum;
	private String email;
}
