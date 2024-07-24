package com.kh.pjtMungHub.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {

	private int replyNo;
	private String replyContent;
	private String replyWriter;
	private int refBno;
	private Date createDate;
	private String replyStatus;
	
	private int userNo;
	private String userId;

}
