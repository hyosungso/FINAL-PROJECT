package com.kh.pjtMungHub.shop.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewReply {
	
	private int replyNo;
	private String replyContent;
	private int reviewNo;
	private int userNo;
	private Date createDate;
	
	private String userName;
}
