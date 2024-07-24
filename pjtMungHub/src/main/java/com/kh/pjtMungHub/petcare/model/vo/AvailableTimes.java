package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AvailableTimes {
    private int petSitterNo; // PET_SITTER_NO NUMBER NOT NULL
    private String visitDate; // VISIT_DATE DATE NOT NULL
    private String startTime; // START_TIME DATE NOT NULL
    private String endTime; // END_TIME DATE NOT NULL
    private String duration;
    private String petTypeNo;
    private int totalPrice;
    private String priceName;
}
