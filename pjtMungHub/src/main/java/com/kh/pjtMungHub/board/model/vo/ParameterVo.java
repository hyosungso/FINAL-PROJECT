package com.kh.pjtMungHub.board.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ParameterVo {
	
	
	private int offset;
	private int limit;
	private int category;
	private String sort;
	
	private ArrayList<Attachment> aList;
	private Attachment a;
	private int number;
	private String[] items;
	
	private int boardNo;
	

}