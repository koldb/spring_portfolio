package com.spring.vo;

public class ScheduleVO {

	private int num;
	private String subject;
	private String startDate;
	private String endDate;
	private String memo;
	private String writer;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "ScheduleVO [num=" + num + ", subject=" + subject + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", memo=" + memo + ", writer=" + writer + "]";
	}
	
	
	
	
	
	
}
