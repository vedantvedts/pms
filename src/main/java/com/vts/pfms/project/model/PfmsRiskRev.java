package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_risk_rev")
public class PfmsRiskRev {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long RiskRevisionId;
	private String LabCode;
	private Long ProjectId;
    private Long ActionMainId;
    private String Description;
    private int Severity;
    private int Probability;
    private int RPN;
    private String MitigationPlans;
    private String Impact;
    private Long RevisionNo;
    private String Category;
    private int RiskTypeId;
    private String RevisionDate;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    
    
	
}
