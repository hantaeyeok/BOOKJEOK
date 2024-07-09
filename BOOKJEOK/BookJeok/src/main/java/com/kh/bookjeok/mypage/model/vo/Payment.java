package com.kh.bookjeok.mypage.model.vo;


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
public class Payment {
	private String orderNo;
	private String userId;
	private String paymentStatus;
	private String paymentTool;
	private String paymentDate;
	private String paymentCard;
	private int paymentPeriod;
	private String paymentBank;
	private int paymentPrice;
	private int mileageGet;
	private int mileageUsed;
}