package com.kh.pjtMungHub.member.model.vo;
 
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private int userNo;
	private String userId;
	private String password;
	private String name;
	private String phone;
	private String email;
	private String address;
	private String petYN;
	private String userGrade;
	private String kindName;
	private String status;
	private Date joinDate;
	private String sitterStatus;
	private int days;
}
