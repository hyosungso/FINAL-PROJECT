package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
    private String reservationId; // RESERVATION_ID NUMBER PRIMARY KEY
    private String petOwnerName;//PET_OWNER_NAME VARCHAR2(50) NOT NULL
    private String address; // ADDRESS VARCHAR2(200) NOT NULL
    private String phone; // PHONE VARCHAR2(20) NOT NULL
    private Date visitDate; // VISIT_DATE DATE NOT NULL
    private int startTime; // START_TIME NUMBER NOT NULL
    private String endTime; // END_TIME NUMBER NOT NULL
    private Date reservationDate; // RESERVATION_DATE DATE DEFAULT SYSDATE NOT NULL
    private String caution; // CAUTION VARCHAR2(2000) NOT NULL
    private String petName; // PET_NAME VARCHAR2(200) NOT NULL
    private int status; // STATUS NUMBER DEFAULT 1 NOT NULL
    private String petSitterNo; // PET_SITTER_NO NUMBER NOT NULL
    private int duration; // DURATION NUMBER NOT NULL
    private String petTypeNo; // PET_TYPE NUMBER NOT NULL
    private String originName;//    ORIGIN_NAME VARCHAR2(1000 BYTE),
    private String changeName;//    CHANGE_NAME VARCHAR2(1000 BYTE),
    private String paymentStatus; // PAYMENT_STATUS NUMBER NOT NULL
    private String userNo;
    private int totalAmount; // TOTAL_AMOUNT NUMBER NOT NULL
}
