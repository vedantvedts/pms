package com.vts.pfms.committee.dto;

import lombok.Data;

@Data
public class CommitteeMainDto {

	private String CommitteeMainId;
	private String CommitteeId;
	private String ValidFrom;
	private String ValidTo;
	private String CpLabCode;
	private String Chairperson;
	private String Co_Chairperson;
	private String Secretary;
	private String ProxySecretary;
	private String LabCode;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
	private String ProjectId;
	private String DivisionId;
	private String InitiationId;
	private String[] reps;
	private String CreatedByEmpid;
	private String CreatedByEmpidLabid;
	private String PreApproved;
	
	private String msLabCode;
	private String ReferenceNo;
	private String FormationDate;
	
}
