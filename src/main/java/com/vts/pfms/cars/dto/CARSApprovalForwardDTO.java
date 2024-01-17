package com.vts.pfms.cars.dto;

import lombok.Data;

@Data
public class CARSApprovalForwardDTO {

	private long carsinitiationid;
	private String action;
	private String EmpId;
	private String UserId;
	private String remarks;
	private String labcode;
	private String approvalSought;
	private String approverEmpId;
	private String approvalDate;
	
}
