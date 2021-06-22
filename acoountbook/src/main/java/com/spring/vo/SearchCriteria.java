package com.spring.vo;

public class SearchCriteria extends Criteria{

	private String searchType = "";
	private String keyword = "";
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String serachType) {
		this.searchType = serachType;
	}
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
	
	
}
