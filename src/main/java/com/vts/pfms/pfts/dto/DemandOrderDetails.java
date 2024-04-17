package com.vts.pfms.pfts.dto;

import java.sql.Date;

import lombok.Data;
@Data
public class DemandOrderDetails {
	private String OrderNo;
	private String OrderDate;
	private Double OrderCost;
	private String DpDate;
	private String RevisedDp;
	private String VendorName;
	private String ItemFor;
	
	private String isPresent;
	
	
}
