package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class PfmsRiskDto {

	    private String RiskId;
		private String ProjectId;
	    private String ActionMainId;
	    private String Description;
	    private String Severity;
	    private String Probability;
	    private String MitigationPlans;
	    private String Impact;
	    private String RevisionNo;
	    private String CreatedBy;
	    private String CreatedDate;
	    private String ModifiedBy;
	    private String ModifiedDate;
	    private String IsActive;
	    private String LabCode;
	    private String Category;
	    private String RiskTypeId;
	    
	    
}
