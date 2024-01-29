package com.vts.pfms.cars.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CARSContractDetailsDTO {
	private long CARSInitiationId;
	private String[] consultantName;
	private String[] consultantCompany;
	
	private String[] equipmentDescription;
	
	private String UserId;
}
