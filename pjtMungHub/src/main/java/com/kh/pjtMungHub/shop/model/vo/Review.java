package com.kh.pjtMungHub.shop.model.vo;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Review {

	private int reviewNo;
	private String reviewContent;
	private int userNo;
	private String userName;
	private int productNo;
	private Date createDate;
	private int likeCount;
	private int score;
	
	private int currentPage;
	private int star;
	
	private String type;
}
