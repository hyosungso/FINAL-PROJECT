package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HouseReservation {
    private int reservationHouseNo; // RESERVATION_HOUSE_NO NUMBER PRIMARY KEY
    private String houseNo; // HOUSE_NO VARCHAR2(50) NOT NULL
    private Date startDate; // START_DATE DATE NOT NULL
    private Date endDate; // END_DATE DATE NOT NULL
    private int stayNo; // STAY_NO NUMBER NOT NULL
    private String caution; // CAUTION VARCHAR2(2000) NOT NULL
    private String petOwnerName; // PET_OWNER_NAME VARCHAR2(200) NOT NULL
    private String address;
    private String phone; // PHONE VARCHAR2(50) NOT NULL
    private String originName; // ORIGIN_NAME VARCHAR2(1000 BYTE)
    private String changeName; // CHANGE_NAME VARCHAR2(1000 BYTE)
    private int status; // STATUS NUMBER DEFAULT 1 NOT NULL
    private int paymentStatus; // PAYMENT_STATUS NUMBER DEFAULT 1 NOT NULL
    private String userId; // USER_ID VARCHAR2(100) NOT NULL
    private int totalAmount; // TOTAL_AMOUNT NUMBER NOT NULL
    private String pet; // 
    private String walk; // 
    private String petTypeNo; // 
}
