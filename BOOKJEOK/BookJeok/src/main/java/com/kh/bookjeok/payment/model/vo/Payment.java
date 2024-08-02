package com.kh.bookjeok.payment.model.vo;

import java.sql.Date;

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
public class Payment {
	
	private int orderNo;
	private String userId;
	private Date paymentDate;
	private String paymentCard;
	private String paymentCardNum;
	private int paymentPeriod;
	private String paymentTool;
	private String paymentStatus;
	private String deliveryStatus;
	private String paymentBank;
	private String totalPrice;
	private String paymentPrice;
	private int mileageUsed;
	private int mileageGet;
	

}
