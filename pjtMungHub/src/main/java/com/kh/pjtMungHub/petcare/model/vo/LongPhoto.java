package com.kh.pjtMungHub.petcare.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LongPhoto {
    private int photoNo; // PHOTO_NO NUMBER PRIMARY KEY
    private String originName; // ORIGIN_NAME VARCHAR2(255 BYTE) NOT NULL
    private String changeName; // CHANGE_NAME VARCHAR2(255 BYTE) NOT NULL
    private String filePath; // FILE_PATH VARCHAR2(2000 BYTE) NOT NULL
    private Date uploadDate; // UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL
    private String status; // STATUS VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL
    private String photoType; // PHOTO_TYPE NUMBER NOT NULL
}
