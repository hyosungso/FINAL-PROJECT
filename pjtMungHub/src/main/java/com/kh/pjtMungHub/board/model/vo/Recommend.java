package com.kh.pjtMungHub.board.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recommend {
	
	private int boardNo;
	private int userNo;
	private String status;
	private int rcount;
}
