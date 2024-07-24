package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class House {
    private int houseNo; // HOUSE_NO NUMBER PRIMARY KEY
    private String ownerName; // OWNER_NAME VARCHAR2(50) NOT NULL
    private String introductionSummary; // INTRODUCTION_SUMMARY VARCHAR2(255) NOT NULL
    private String houseAddress; // HOUSE_ADDRESS VARCHAR2(255) NOT NULL
    private String introductionDetailed; // INTRODUCTION_DETAILED VARCHAR2(4000) NOT NULL
    private String nearbyHospital; // NEARBY_HOSPITAL VARCHAR2(1000) NOT NULL
    private String environmentInfo; // ENVIRONMENT_INFO VARCHAR2(1000) NOT NULL
    private String supplyGuide; // SUPPLY_GUIDE VARCHAR2(1000) NOT NULL
    private String certification; // CERTIFICATION VARCHAR2(1000) NOT NULL
    private String originName01; // ORIGIN_NAME VARCHAR2(1000 BYTE)
    private String originName02; // ORIGIN_NAME VARCHAR2(1000 BYTE)
    private String originName03; // ORIGIN_NAME VARCHAR2(1000 BYTE)
    private String housePetNo;
    private String houseWalkNo;
    private String petTypeNo;
    private String filePath; // CHANGE_NAME VARCHAR2(1000 BYTE)
}
