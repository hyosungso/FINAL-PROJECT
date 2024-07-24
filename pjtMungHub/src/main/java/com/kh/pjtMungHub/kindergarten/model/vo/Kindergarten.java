package com.kh.pjtMungHub.kindergarten.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Kindergarten {
private int kindNo;//	KIND_NO
private String directorId;//	DIRECTOR_ID
private String regionName;//	REGION_NAME
private String kindAddress;//	KIND_ADDRESS
private String kindName;//	KIND_NAME
private String kindContact;//	KIND_CONTACT
private double placeX;//	PLACE_X
private double placeY;//	PLACE_Y
private String status;//	STATUS
}
