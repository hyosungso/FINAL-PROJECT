package com.kh.pjtMungHub.shop.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {

	private int productNo;
	private int amount;
	private int userNo;
	
	private String productName;
	private int price;
	private int discount;
	private String brandName;
	private String categoryName;
	private String img;
	private String imgType;
}
