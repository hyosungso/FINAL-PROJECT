package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HospitalRe {
	private int hosReNo; //예약번호
	private String userNo; // MEMBER 의 외래키
	private String petOwnerName; //펫주인이름
	private String ownerPhone; //펫주인 연락처
	private String hosName; //병원이름
	private String hosPhone; //병원연락처
	private String hosAddress; //병원주소
	private Date reDate; //예약일자 DEFAULT SYSDATE
	private String reTime; //예약시간
	private String petName; //펫이름
	private String petKind; //견종
	private Date petBirthDay; //펫생일
	private String petGender; //펫성별
	private String neutralization; //중성화 유무 DEFAULT 'N'
	private String specialNotes; //특이사항
	private String petTypeNo; //대중소 펫크기
	private String petTypeName; //대중소 펫크기
	private String symptom; //증상
	private String originName; //펫사진 원래이름
	private String changeName; //펫사진 서버저장 이름
	private String diseaseName; //예상병명
	private String status; //예약상태
	private Date updateDay; //예약 변경일자 DEFAULT SYSDATE
}
