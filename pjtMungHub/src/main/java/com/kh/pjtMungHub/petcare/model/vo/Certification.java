package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Certification {
	private int certificationNo;//	CERTIFICATION_NO	NUMBER
	private String certificationName;//	CERTIFICATION_NAME	VARCHAR2(255 BYTE)
	private String originName;//	ORIGIN_NAME	VARCHAR2(200 BYTE)
	private String filePath;//	FILE_PATH	VARCHAR2(2000 BYTE)
}
