package com.spring.vo;

import java.util.Date;

public class AccountVO {

	private int accNum;
	private String userId;
	private String accDiv;
	private String accCategory;
	private String accDate;
	private String accComment;
	private String accAmount;
	public int getAccNum() {
		return accNum;
	}
	public void setAccNum(int accNum) {
		this.accNum = accNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAccDiv() {
		return accDiv;
	}
	public void setAccDiv(String accDiv) {
		this.accDiv = accDiv;
	}
	public String getAccCategory() {
		return accCategory;
	}
	public void setAccCategory(String accCategory) {
		this.accCategory = accCategory;
	}
	public String getAccDate() {
		return accDate;
	}
	public void setAccDate(String accDate) {
		this.accDate = accDate;
	}
	public String getAccComment() {
		return accComment;
	}
	public void setAccComment(String accComment) {
		this.accComment = accComment;
	}
	public String getAccAmount() {
		return accAmount;
	}
	public void setAccAmount(String accAmount) {
		this.accAmount = accAmount;
	}
	@Override
	public String toString() {
		return "AccountVO [accNum=" + accNum + ", userId=" + userId + ", accDiv=" + accDiv + ", accCategory="
				+ accCategory + ", accDate=" + accDate + ", accComment=" + accComment + ", accAmount=" + accAmount
				+ "]";
	}
	
	
	
	
	
	
}
