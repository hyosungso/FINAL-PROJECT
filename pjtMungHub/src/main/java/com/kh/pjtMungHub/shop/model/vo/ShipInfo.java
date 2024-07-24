package com.kh.pjtMungHub.shop.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShipInfo {

	private int infoNo;
	private int userNo;
	private String address;
	private String addressDetail;
	private String recipient;
	private String phone;
	private String choosed;
	
}
