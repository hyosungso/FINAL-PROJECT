package com.kh.pjtMungHub.petcare.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SupplyGuide {
	private int supplyGuideNo;
	private String supplyGuideName;
	private String originName;
	private String filePath;
}
