package com.kh.pjtMungHub.shop.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	
	private int questionNo;
	private int productNo;
	private int userNo;
	private String userName;
	private String content;
	private int categoryNo;
	private String categoryName;
	private String openStatus;
	private Date createDate;
	private String answerStatus;
}
