package com.kh.pjtMungHub.board.model.service;

import java.util.ArrayList;

import com.kh.pjtMungHub.board.model.vo.Attachment;
import com.kh.pjtMungHub.board.model.vo.Board;
import com.kh.pjtMungHub.board.model.vo.Category;
import com.kh.pjtMungHub.board.model.vo.ParameterVo;
import com.kh.pjtMungHub.board.model.vo.Recommend;
import com.kh.pjtMungHub.board.model.vo.Reply;
import com.kh.pjtMungHub.common.model.vo.PageInfo;

public interface BoardService {
	
	//게시글 목록과 페이징처리까지
		//게시글 총 개수 조회
		//해당 카테고리 게시물 총 개수 조회
		int listCount(int category);
		//게시글 목록 조회
		ArrayList<Board> selectList(PageInfo pi, String sort);
		//가지고있는 카테고리 개수 조회
		ArrayList<Category> selectCategory();
		//카테고리 포함한 목록 조회
		ArrayList<Board> selectList(PageInfo pi, String sort, int category);
		//조회수 증가
		int increaseCount(int boardNo);
		//검색
		int searchCount(int category);

		//게시물 상세보기
		Board selectBoard(int boardNo);
		//게시물 만들기
		int insertBoard(Board b,ParameterVo fileParameter);
		//게시물 삭제
		int deleteBoard(int boardNo);
		//게시물 업데이트
		int updateBoard(Board b);
		
		//검색 기능
		ArrayList<Board> searchList(PageInfo pi, String sort, String keyword);
		ArrayList<Board> searchList(PageInfo pi, String sort, String keyword, int category);
		
		
		
		
		
		
		
		
		//댓글 목록 조회
		ArrayList<Reply> replyList(int boardNo);
		//댓글 입력 
		int insertReply(Reply r);

		int deleteReply(int replyNo);

		int updateLike(Recommend r);

		int likeCount(Recommend r);

		//해당 게시물 파일 리스트
		ArrayList<Attachment> AttachmentList(int boardNo);
		ArrayList<Attachment> selectAttachmentList(ParameterVo fileparameter);
		int updateAttachment(ParameterVo parameter);





}
