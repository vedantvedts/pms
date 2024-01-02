package com.vts.pfms.cars.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CARSRSQRDetailsDTO {

	private long CARSInitiationId;
	private String[] ReqId;
	private String[] ReqDescription;
	private String[] RelevantSpecs;
	private String[] ValidationMethod;
	private String[] Remarks;
	private String[] Description;
	private String[] DeliverableType;
	private String UserId;
	
	private String[] MilestoneNo;
	private String[] TaskDesc;
	private String[] Months;
	private String[] Deliverables;
	private String[] PaymentTerms;
}
