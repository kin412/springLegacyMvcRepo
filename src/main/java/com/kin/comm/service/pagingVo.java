package com.kin.comm.service;

import lombok.Data;

@Data
public class pagingVo {

	private int 	startPage;			//시작번호
	private int 	endPage;			//끝번호
	private int    	pageSize;			//한 페이지의 글 개수
	private int	   	currentPage;		//현재 페이지
	private int 	totalPages;  		//전체 페이지 수
	private int	   	beforePage = 0;		//이전 페이지
	private int    	afterPage = 0;		//다음 페이지
	private String	pageHtml = "";		//페이지 태그
	
	public pagingVo setPaging(int totalCnt) {
		
		//totalCnt - 총 글 갯수
		
		totalPages = totalCnt / pageSize;
		
		if (totalCnt % pageSize > 0) {
			totalPages++;
		}
		
		if (totalPages < currentPage) {
			currentPage = totalPages;
		}
		
		startPage = ((currentPage - 1) / 10) * 10 + 1;
		endPage = startPage + 10 - 1;
		
		if (endPage > totalPages) {
			endPage = totalPages;
		}
		
		for (int page = startPage; page <= endPage; page++) {
    		if (currentPage == page) {
    			pageHtml += "<li class='on'><a href='#' onclick='searchPgFunc("+page+")'>"+page+"</a></li>"; 
    		}
    		else {
    			pageHtml += "<li><a href='#' onclick='searchPgFunc("+page+")'>"+page+"</a></li>";
    		}
    	}
		
		if (currentPage > 10) {
    		//beforePage = currentPage - 10;
			beforePage = startPage - 10;
    	}
    	
    	if (endPage < totalPages) {
	    	afterPage = endPage + 1;
    	}
		
		return this;
	}
	
}
