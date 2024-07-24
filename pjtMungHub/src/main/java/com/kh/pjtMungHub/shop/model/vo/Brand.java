package com.kh.pjtMungHub.shop.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Brand {

	private int brandCode;
	private String brandName;
	private int brandSales;
	private int brandSalesCount;
	private String logo;
}
