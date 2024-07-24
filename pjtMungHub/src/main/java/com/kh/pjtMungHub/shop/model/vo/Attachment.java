package com.kh.pjtMungHub.shop.model.vo;

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

	private int fileLev;
	private String originName;
	private String changeName;
	private String status;
	private Date uploadDate;
	private String fileJustify;
	private String filePath;
	private int productNo;
	private int reviewNo;
	private int brandNo;
	private String type;

}
