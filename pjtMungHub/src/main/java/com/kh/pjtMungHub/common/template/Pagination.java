package com.kh.pjtMungHub.common.template;

import com.kh.pjtMungHub.common.model.vo.PageInfo;

public class Pagination {
	// 페이징 처리 메소드
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {

		int maxPage = (int) Math.ceil((double) listCount / boardLimit); // 가장 마지막 페이징바가 몇번인지 (총 페이지 개수)
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1; // 페이지 하단에 보여질 페이징바의 시작수
		int endPage = startPage + pageLimit - 1;

		if (endPage > maxPage) {
			endPage = maxPage; // maxPage값을 endPage변수에 대입해주기
		}

		// 처리된 데이터 객체에 담아주기
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);

		return pi;// 페이징 정보 반환
	}
}
