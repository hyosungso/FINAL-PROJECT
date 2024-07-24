package com.kh.pjtMungHub.wedding.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.member.model.service.MemberService;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.wedding.model.dao.WeddingDao;
import com.kh.pjtMungHub.wedding.model.vo.Wedding;

@Service
public class WeddingServiceImpl implements WeddingService{

	@Autowired
	private WeddingDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public ArrayList<Breed> selectBreeds() {
		return dao.selectBreeds(sqlSession);
	}

	@Override
	public ArrayList<Wedding> selectWeddings() {
		
		return dao.selectWeddings(sqlSession);
	}

	@Override
	public Wedding selectWedding(int weddingNo) {
		return dao.selectWedding(sqlSession, weddingNo);
	}
	
	@Override
	public ArrayList<Pet> selectPets(int userNo) {
		return dao.selectPets(sqlSession,userNo);
	}
	
	@Override
	public int insertWedding(Wedding w, ArrayList<Vaccine> vacList) {
		return dao.insertWedding(sqlSession,w,vacList);
	}
	
	@Override
	public ArrayList<Wedding> selectRegList() {
		return dao.selectRegList(sqlSession);
	}

	@Override
	public int rejectReg(Wedding w) {
		return dao.rejectReg(sqlSession,w);
	}

	@Override
	public int approveReg(int weddingNo) {
	
		return dao.approveReg(sqlSession,weddingNo);
	}

	@Override
	public int countAppliedList(int userNo) {
		return dao.countAppliedList(sqlSession,userNo);
	}


	@Override
	public ArrayList<Wedding> selectAppliedList(Wedding w) {
		return dao.selectAppliedList(sqlSession,w);
	}

	@Override
	public int applyMatching(Wedding w, ArrayList<Vaccine> vacList) {
		return dao.applyMatching(sqlSession, w,vacList);
	}

	@Override
	public int acceptWedding(int weddingNo) {
		return dao.acceptWedding(sqlSession,weddingNo);
	}

	@Override
	public ArrayList<Wedding> selectByBreed(String breedId) {
		return dao.selectByBreed(sqlSession,breedId);
	}

	@Transactional
	@Override
	public int cancelWedding(int weddingNo, int userNo) {
		dao.cancelWedding(sqlSession,weddingNo);
		return memberService.restrictUser(userNo, 14);
	}

	@Override
	public Pet selectPetByNo(int petNo) {
		return dao.selectPetByNo(sqlSession,petNo);
	}

	@Override
	public ArrayList<Member> getContactInfo(int weddingNo) {
		return dao.getContactInfo(sqlSession, weddingNo);
	}

	@Override
	public int updateWedding(Wedding w) {
		return dao.updateWedding(sqlSession,w);
	}

	@Override
	public int deleteWedding(int weddingNo) {
		return dao.deleteWedding(sqlSession,weddingNo);
	}


}
