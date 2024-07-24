package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PetSitter {
    private int petSitterNo; // PET_SITTER_NO NUMBER PRIMARY KEY
    private String petSitterName; // PET_SITTER_NAME VARCHAR2(100) NOT NULL
    private String introduce;//    INTRODUCE VARCHAR2(200) NOT NULL,
    private String dogKeyword;//    DOG_KEYWORD VARCHAR2(15) NOT NULL,
    private String typeKeyword;//    TYPE_KEYWORD VARCHAR2(15) NOT NULL,
    private String phone; // PHONE VARCHAR2(15) NOT NULL
    private String email; // EMAIL VARCHAR2(100)
    private String originName;//    ORIGIN_NAME	VARCHAR2(200 BYTE)
    private String filePath;//    FILE_PATH	VARCHAR2(2000 BYTE)
    private String status; // STATUS VARCHAR2(10) DEFAULT 'N' NOT NULL
}
