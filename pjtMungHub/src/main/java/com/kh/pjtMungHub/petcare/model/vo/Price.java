package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Price {
    private int durationNo; // DURATION_NO NUMBER
    private int petTypeNo; // PET_TYPE_NO NUMBER
    private int totalPrice; // TOTAL_PRICE NUMBER NOT NULL
    private String priceName; // PRICE_NAME VARCHAR2(100) NOT NULL
}
