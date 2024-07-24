package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HousePrice {
	private int stayNo;//STAY_NO NUMBER NOT NULL PRIMARY KEY,
    private String stayName;//STAY_NAME VARCHAR2(50) NOT NULL,
    private int price;//PRICE NUMBER NOT NULL
}
