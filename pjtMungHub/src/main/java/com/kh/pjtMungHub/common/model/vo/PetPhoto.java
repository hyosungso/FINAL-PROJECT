package com.kh.pjtMungHub.common.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PetPhoto {
    private int photoNo; // PHOTO_NO NUMBER PRIMARY KEY
    private String originName; // ORIGIN_NAME VARCHAR2(1000 BYTE) NOT NULL
    private String changeName; // CHANGE_NAME VARCHAR2(1000 BYTE) NOT NULL
    private String filePath; // FILE_PATH VARCHAR2(2000 BYTE) NOT NULL
    private Date uploadDate; // UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL
    private String status; // STATUS VARCHAR2(3 BYTE) DEFAULT 'Y' NOT NULL
}
