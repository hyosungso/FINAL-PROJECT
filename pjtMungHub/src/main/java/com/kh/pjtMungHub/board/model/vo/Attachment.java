package com.kh.pjtMungHub.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Attachment {
		
		private int attBno;
		private String originName;//	ORIGIN_NAME	VARCHAR2(255 BYTE)
		private String changeName;//	CHANAGE_NAME	VARCHAR2(255 BYTE)
		private String filePath;//	FILE_PATH	VARCHAR2(1000 BYTE)
		private int fileLevel;//	FILE_LEVEL	NUMBER
		private String fileType;
		private Date uploadDate;
		private String fileStatus;//	FILE_STATUS	VARCHAR2(1 BYTE)
		
		
		

}
