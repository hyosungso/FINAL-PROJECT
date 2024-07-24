package com.kh.pjtMungHub.wedding.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Wedding {
private int weddingNo;//	WEDDING_NO	NUMBER
private String petNo;
private String petName;
private String breed;
private int userNo;//	USER_NO	NUMBER
private String userName;
private int petAge;
private double weight;
private String pedigree;//
private String gender;//PEDIGREE	VARCHAR2(50 BYTE)
private String meetingMethod;//	MEETING_METHOD	VARCHAR2(20 BYTE)
private String petIntro;//	PET_INTRO	VARCHAR2(600 BYTE)
private String petNote;//	PET_NOTE	VARCHAR2(400 BYTE)
private String originName;//ORIGIN_NAME
private String changeName;//CHANGE_NAME
private String approval;//	APPROVAL	CHAR(1 BYTE)
private String reason;//거절사유 필드
private int partnerNo;//매칭 상대방 강아지 번호
private String partnerName;
}
