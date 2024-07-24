package com.kh.pjtMungHub.shop.model.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetail {
	
	private int detailNo;
	private int productNo;
	private String originContry;
	private String manufacturer;
	private String phone;
	private String expireDate;
	private String recommendedAge;
	private String weight;
	private String ingredient;
	private String component;
}
