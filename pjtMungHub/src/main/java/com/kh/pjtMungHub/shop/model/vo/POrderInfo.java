package com.kh.pjtMungHub.shop.model.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class POrderInfo {
	
	private String merchantUid;
	private String process;
	private String items;
	private String itemsQuantity;
	private int totalPrice;
	private int userNo;
	private Date payDate;
	private Date updateDay;
	private HashMap<String,String> message;
	private String messageString;
	
	private String address;
	private String phone;
	private String recipient;
	
	private int[] itemsArr;
	private ArrayList<Product> pList;
	private int[] itemsQuantityArr;
	
	
	
}
