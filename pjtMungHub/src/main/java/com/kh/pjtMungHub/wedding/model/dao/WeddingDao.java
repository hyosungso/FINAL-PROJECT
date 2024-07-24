package com.kh.pjtMungHub.wedding.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.wedding.model.vo.Wedding;

@Repository
public class WeddingDao {

	//견종 조회 메서드
	public ArrayList<Breed> selectBreeds(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectBreeds");
	}

	//웨딩 목록 조회 메서드
	public ArrayList<Wedding> selectWeddings(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectWeddings");
	}

	//웨딩 정보 상세 조회 메서드
	public Wedding selectWedding(SqlSessionTemplate sqlSession, int weddingNo) {
		return sqlSession.selectOne("weddingMapper.selectWedding",weddingNo);
	}

	public ArrayList<Pet> selectPets(SqlSessionTemplate sqlSession,int userNo) {
		return (ArrayList)sqlSession.selectList("weddingMapper.selectPets",userNo);
	}

	//해당 메소드를 하나의 트랜잭션으로 관리할 것
	@Transactional
	public int insertWedding(SqlSessionTemplate sqlSession, Wedding w, ArrayList<Vaccine> vacList) {
		int result = sqlSession.insert("weddingMapper.insertWedding",w);
		int result2 = 1;
			for	(Vaccine v:vacList) {
				result2 *= sqlSession.insert("weddingMapper.insertVaccine",v);
			}
		return result*result2;
	}

	public ArrayList<Wedding> selectRegList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("weddingMapper.selectRegList");
	}

	//웨딩플랜 신청 거절 메서드
	public int rejectReg(SqlSessionTemplate sqlSession, Wedding w) {
		return sqlSession.update("weddingMapper.rejectReg",w);
	}

	//웨딩플랜 신청 승인 메서드
	public int approveReg(SqlSessionTemplate sqlSession, int weddingNo) {

		return sqlSession.update("weddingMapper.approveReg",weddingNo);
	}

	//신청한 만남 조회해오는 메서드
	public int countAppliedList(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("weddingMapper.countAppliedList",userNo);
	}

	@Transactional
	//만남 신청 메서드
	public int applyMatching(SqlSessionTemplate sqlSession, Wedding w, ArrayList<Vaccine> vacList) {
		//만남 신청 처리
		int result1 = sqlSession.insert("weddingMapper.applyMatching",w);
		//백신 접종 증명서 추가
		int result2 =1;
		for(Vaccine v:vacList) {
		result2 *=sqlSession.insert("weddingMapper.insertVaccine",v);	
		}
		return result1 * result2;
	}

	@Transactional
	//만남 신청 내역 조회 메서드
	public ArrayList<Wedding> selectAppliedList(SqlSessionTemplate sqlSession, Wedding w) {
		//담아온 userNo만을 가지고 신청한 weddingList 전체 조회
		ArrayList<Wedding>appliedList = (ArrayList)sqlSession.selectList("weddingMapper.selectAppliedList",w);
		ArrayList<Wedding>receivedList = (ArrayList)sqlSession.selectList("weddingMapper.selectReceivedList", w);
		appliedList.addAll(receivedList);

		return appliedList;
	}

	//만남 수락 메서드
	public int acceptWedding(SqlSessionTemplate sqlSession, int weddingNo) {
		
		return sqlSession.update("weddingMapper.acceptWedding",weddingNo);
	}

	public ArrayList<Wedding>selectByBreed(SqlSessionTemplate sqlSession,String breedId){
		return (ArrayList)sqlSession.selectList("weddingMapper.selectByBreed",breedId);
	}
	
	public int cancelWedding(SqlSessionTemplate sqlSession, int weddingNo) {
		return sqlSession.update("weddingMapper.cancelWedding",weddingNo);
	}

	public Pet selectPetByNo(SqlSessionTemplate sqlSession,int petNo) {
		return sqlSession.selectOne("weddingMapper.selectPetByNo",petNo);
	}
	
	public ArrayList<Member> getContactInfo(SqlSessionTemplate sqlSession,int weddingNo){
		return (ArrayList)sqlSession.selectList("weddingMapper.getContactInfo", weddingNo);
	}

	public int updateWedding(SqlSessionTemplate sqlSession, Wedding w) {
		return sqlSession.update("weddingMapper.updateWedding",w);
	}
	
	public int deleteWedding(SqlSessionTemplate sqlSession, int weddingNo) {
		return sqlSession.delete("weddingMapper.deleteWedding",weddingNo);
	}
}
