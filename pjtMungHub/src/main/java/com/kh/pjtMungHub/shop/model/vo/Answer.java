package com.kh.pjtMungHub.shop.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Answer {

	
	private int answerNo;
	private int questionNo;
	private int userNo;
	private String content;
	private Date createDate;
}
