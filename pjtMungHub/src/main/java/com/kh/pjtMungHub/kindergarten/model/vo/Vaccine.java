package com.kh.pjtMungHub.kindergarten.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Vaccine {
	private int fileNo;
	private String petNo;
	private String originName;
	private String changeName;
}
