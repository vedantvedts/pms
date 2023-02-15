package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_risk")
public class PfmsRisk implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long RiskId;
	private String LabCode;
	private Long ProjectId;
    private Long ActionMainId;
    private String Description;
    private int Severity;
    private int Probability;
    private int RPN;
    private String MitigationPlans;
    private String Impact;
    private String Category;
    private int RiskTypeId;
    private Long RevisionNo;
    private String Status;
    private String StatusDate;
    private String Remarks; 
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private int IsActive;
    
    
}
