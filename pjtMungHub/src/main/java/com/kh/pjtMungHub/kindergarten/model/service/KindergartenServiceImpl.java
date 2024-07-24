package com.kh.pjtMungHub.kindergarten.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pjtMungHub.kindergarten.model.dao.KindergartenDao;
import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.kindergarten.model.vo.Registration;
import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.pet.model.vo.Pet;

@Service
public class KindergartenServiceImpl implements KindergartenService{
	
	@Autowired
	private KindergartenDao dao;
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public ArrayList<Kindergarten> selectMap() {
		
		ArrayList<Kindergarten> mapList = dao.selectMap(sqlsession);
		
		return mapList;
	}

	//해당 회원의 반려동물 정보 조회 메서드
	@Override
	public ArrayList<Pet> selectPets(int ownerNo) {
		ArrayList<Pet> pet = dao.selectPets(sqlsession,ownerNo);
		return pet;
	}

	@Override
	public Pet selectPetByNo(int petNo) {
		return dao.selectPet(sqlsession,petNo);
	}
	
	@Override
	public Kindergarten selectKindergarten(int kindNo) {
		Kindergarten kindergarten = dao.selectKindergarten(sqlsession, kindNo);
		return kindergarten;
	}

	//상담신청등록메소드
	@Override
	public int insertReg(Registration reg) {
		int result = dao.insertReg(sqlsession,reg);
		return result;
	}

	//상담신청리스트조회메소드(견주)
	@Override
	public ArrayList<Registration> selectRegList(int userNo) {
		
		return dao.selectRegList(sqlsession,userNo);
	}
	
	//상담신청리스트조회메소드(원장)
	@Override
	public ArrayList<Registration> selectRegList2(int userNo) {
		
		return dao.selectRegList2(sqlsession,userNo);
	}

	//상담신청상세조회메소드
	@Override
	public Registration selectRegistration(int reservNo) {

		return dao.selectRegistration(sqlsession,reservNo);
	}

	//상담취소메소드
	@Override
	public int deleteReg(int reservNo) {
		
		return dao.deleteReg(sqlsession,reservNo);
	}

	//상담신청수정 메서드
	@Override
	public int updateReg(Registration reg) {
		return dao.updateReg(sqlsession,reg);
	}

	//등록상담신청승인 메서드
	@Override
	public int approveReg(int reservNo) {
		return dao.approveReg(sqlsession,reservNo);
	}

	//등록상담거절 메서드
	@Override
	public int rejectReg(Registration r) {
		return dao.rejectReg(sqlsession,r);
	}
	
	//백신정보추가 메서드
	@Override
	public int insertVac(ArrayList<Vaccine> vacList) {
		return dao.insertVac(sqlsession,vacList);
	}


	


}
