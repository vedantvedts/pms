package com.vts.pfms.committee.dto;

import lombok.Data;

@Data
public class CommitteeDto {

	private Long CommitteeId;
	
	private String CommitteeShortName;
	private String CommitteeName;
	private String CommitteeType;
	private String ProjectApplicable;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String TechNonTech;
	private String Guidelines;
	private String PeriodicNon;
	private String PeriodicDuration;
	private String Description;
	private String TermsOfReference;
	private String IsGlobal;
	private String IsBriefing;
	private String LabCode;
	private String ReferenceNo;
	
	
}

