package com.kh.pjtMungHub.wedding.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.pjtMungHub.kindergarten.model.vo.Vaccine;
import com.kh.pjtMungHub.member.model.vo.Member;
import com.kh.pjtMungHub.pet.model.vo.Breed;
import com.kh.pjtMungHub.pet.model.vo.Pet;
import com.kh.pjtMungHub.wedding.model.vo.Wedding;

public interface WeddingService {

	ArrayList<Breed> selectBreeds();

	ArrayList<Wedding> selectWeddings();

	Wedding selectWedding(int weddingNo);

	ArrayList<Pet> selectPets(int userNo);

	int insertWedding(Wedding w, ArrayList<Vaccine> vacList);

	int updateWedding(Wedding w);
	
	int deleteWedding(int weddingNo);

	ArrayList<Wedding> selectRegList();
	
	int rejectReg(Wedding w);

	int approveReg(int weddingNo);

	int countAppliedList(int userNo);

	int applyMatching(Wedding w, ArrayList<Vaccine> vacList);

	ArrayList<Wedding> selectAppliedList(Wedding w);

	int acceptWedding(int weddingNo);

	ArrayList<Wedding> selectByBreed(String breedId);

	int cancelWedding(int weddingNo,int userNo);

	Pet selectPetByNo(int petNo);

	ArrayList<Member>getContactInfo(int weddingNo);



}
