package com.vts.pfms.model;

import lombok.Data;

@Data
public class FinanceChanges {

	private String Type;
	private String Table;
	private Long PrimaryKey;
	private Long ProjectId;
	private String RefNo;
	private String Date;
	private String ItemFor;
	private Double Cost;
	private String FirstName;
	private String LastName;
	private String CreatedDate;
	private String Designation;
	
}
