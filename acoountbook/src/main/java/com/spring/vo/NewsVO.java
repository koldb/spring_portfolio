package com.spring.vo;

public class NewsVO {
	
	private String href;
	private String title;
	private String writer;
	private String writeDate;
	private String sid1;
	
	public String getSid1() {
		return sid1;
	}

	public void setSid1(String sid1) {
		this.sid1 = sid1;
	}

	public NewsVO() {
		// TODO Auto-generated constructor stub
	}
	
	public NewsVO(String href, String title, String writer, String writeDate) {
		super();
		this.href = href;
		this.title = title;
		this.writer = writer;
		this.writeDate = writeDate;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	@Override
	public String toString() {
		return "NewsVO [href=" + href + ", title=" + title + ", writer=" + writer + ", writeDate=" + writeDate
				+ ", sid1=" + sid1 + "]";
	}

	
	
	

}
