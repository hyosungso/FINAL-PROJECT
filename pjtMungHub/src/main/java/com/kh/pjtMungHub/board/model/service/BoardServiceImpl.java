package com.kh.pjtMungHub.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.pjtMungHub.board.model.dao.BoardDao;
import com.kh.pjtMungHub.board.model.vo.Attachment;
import com.kh.pjtMungHub.board.model.vo.Board;
import com.kh.pjtMungHub.board.model.vo.Category;
import com.kh.pjtMungHub.board.model.vo.ParameterVo;
import com.kh.pjtMungHub.board.model.vo.Recommend;
import com.kh.pjtMungHub.board.model.vo.Reply;
import com.kh.pjtMungHub.common.model.vo.PageInfo;


@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDao boardDao;

	//해당 카테고리 게시물 조회
	@Override
	public int listCount(int category) {
		// TODO Auto-generated method stub
		return boardDao.listCount(sqlSession,category);
	}
	@Override
	public int searchCount(int category) {
		// TODO Auto-generated method stub
		return boardDao.searchCount(sqlSession,category);
	}
	//카테고리 선택
	@Override
	public ArrayList<Category> selectCategory() {
		// TODO Auto-generated method stub
		return boardDao.selectCategory(sqlSession);
	}
	
	 @Override
	 public ArrayList<Board> selectList(PageInfo pi, String sort) {
		 // TODO Auto-generated method stub
	     return boardDao.selectList(sqlSession, pi, sort);
	 }
	@Override
	public ArrayList<Board> selectList(PageInfo pi, String sort, int category) {
		// TODO Auto-generated method stub
		return boardDao.selectList(sqlSession,pi,sort,category);
	}

	@Override
	public int increaseCount(int boardNo) {
		// TODO Auto-generated method stub
		
		return boardDao.increaseCount(sqlSession,boardNo);
	}

	@Override
	public Board selectBoard(int boardNo) {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoard(sqlSession,boardNo);
	}
	@Override
	public ArrayList<Attachment> AttachmentList(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.AttachmentList(sqlSession,boardNo);
	}
	
	@Override
	@Transactional
	public int insertBoard(Board b, ParameterVo fileParameter) {
		// TODO Auto-generated method stub
		
		int result1=boardDao.insertBoard(sqlSession, b);
		int result2=1;
		if(!fileParameter.getAList().isEmpty()) {
			
			result2=boardDao.insertAttachment(sqlSession,fileParameter);
		}
		return result1*result2;
	}
	
	@Override
	public int updateBoard(Board b) {
		// TODO Auto-generated method stub
		return boardDao.updateBoard(sqlSession,b);
	}
	@Override
	public int updateAttachment(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return boardDao.updateAttachment(sqlSession,parameter);
	}

	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.deleteBoard(sqlSession,boardNo);
	}
	
	@Override
	public ArrayList<Reply> replyList(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.replyList(sqlSession,boardNo);
	}
	
	@Override
	public int insertReply(Reply r) {
		// TODO Auto-generated method stub
		return boardDao.insertReply(sqlSession,r);
	}
	@Override
	public int deleteReply(int replyNo) {
		// TODO Auto-generated method stub
		return boardDao.deleteReply(sqlSession,replyNo);
	}
	@Override
	@Transactional
	public int updateLike(Recommend r) {
		// TODO Auto-generated method stub
		int result1= boardDao.updateLike(sqlSession, r);
		
		int result2= boardDao.deleteLike(sqlSession);
		
		
		return result1*result2;
	}
	@Override
	public int likeCount(Recommend r) {
		// TODO Auto-generated method stub
		return boardDao.likeCount(sqlSession,r);
	}
	@Override
	public ArrayList<Attachment> selectAttachmentList(ParameterVo parameter) {
		// TODO Auto-generated method stub
		return boardDao.selectAttachmentList(sqlSession,parameter);
	}
	
	
	
	
	@Override
	public ArrayList<Board> searchList(PageInfo pi, String sort, String keyword) {
		// TODO Auto-generated method stub
		return boardDao.searchList(sqlSession, pi, sort,keyword);
	}
	@Override
	public ArrayList<Board> searchList(PageInfo pi, String sort, String keyword, int category) {
		// TODO Auto-generated method stub
		return boardDao.searchList(sqlSession, pi, sort,keyword,category);
	}

	

}