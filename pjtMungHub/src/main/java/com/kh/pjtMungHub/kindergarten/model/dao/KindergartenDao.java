package com.kh.pjtMungHub.kindergarten.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pjtMungHub.kindergarten.model.vo.Kindergarten;
import com.kh.pjtMungHub.kindergarten.model.vo.Registration;
import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.pet.model.vo.Pet;

@Repository
public class KindergartenDao {

	public ArrayList<Kindergarten> selectMap(SqlSessionTemplate sqlsession) {
		
		
		return (ArrayList)sqlsession.selectList("kindergartenMapper.selectMap");
	}

	public Kindergarten selectKindergarten(SqlSessionTemplate sqlsession, int kindNo) {
		
		
		return sqlsession.selectOne("kindergartenMapper.selectKindergarten",kindNo);
	}

	//해당 회원의 반려동물 정보 조회 메서드
	public ArrayList<Pet> selectPets(SqlSessionTemplate sqlSession,int ownerNo) {
		
		return (ArrayList)sqlSession.selectList("kindergartenMapper.selectPets",ownerNo);
	}
	
	public Pet selectPet(SqlSessionTemplate sqlsession, int petNo) {

		return sqlsession.selectOne("kindergartenMapper.selectPetByNo",petNo);
	}
	
	//상담신청등록 메소드
	public int insertReg(SqlSessionTemplate sqlsession, Registration reg) {
		
		return sqlsession.insert("kindergartenMapper.insertReg",reg);
	}

	//상담신청목록 조회 메소드
	public ArrayList<Registration> selectRegList(SqlSessionTemplate sqlsession, int userNo) {
		
		return (ArrayList)sqlsession.selectList("kindergartenMapper.selectRegList",userNo);
	}

	//상담신청목록 조회 메소드
	public ArrayList<Registration> selectRegList2(SqlSessionTemplate sqlsession, int userNo) {
		
		return (ArrayList)sqlsession.selectList("kindergartenMapper.selectRegList2",userNo);
	}
	//상담신청내역 상세 조회 메소드 
	public Registration selectRegistration(SqlSessionTemplate sqlsession, int reservNo) {

		return sqlsession.selectOne("kindergartenMapper.selectRegistration",reservNo);
	}

	public int deleteReg(SqlSessionTemplate sqlsession, int reservNo) {
		
		return sqlsession.delete("kindergartenMapper.deleteRegistration",reservNo);
	}
	
	//상담신청수정 메서드
	public int updateReg(SqlSessionTemplate sqlsession, Registration reg) {

		return sqlsession.update("kindergartenMapper.updateRegistration",reg);
	}

	//상담신청승인 메서드
	public int approveReg(SqlSessionTemplate sqlsession, int reservNo) {
		return sqlsession.update("kindergartenMapper.approveReg",reservNo);
	}
	
	//상담신청거절 메서드
	public int rejectReg(SqlSessionTemplate sqlsession, Registration r) {
		return sqlsession.update("kindergartenMapper.rejectReg",r);
	}

	public int insertVac(SqlSessionTemplate sqlsession, ArrayList<Vaccine> vacList) {
		int result = 1;
		for(Vaccine v:vacList) {
			result *= sqlsession.insert("kindergartenMapper.insertVac",v);
		}
		return result;
	}




	
	
}
