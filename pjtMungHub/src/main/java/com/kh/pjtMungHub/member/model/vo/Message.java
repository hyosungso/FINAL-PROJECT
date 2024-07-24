package com.kh.pjtMungHub.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
	private int messageNo;
	private String sender;
	private String receiver;
	private String messageContent;
	private Date messageDate;
	private String status;

}
