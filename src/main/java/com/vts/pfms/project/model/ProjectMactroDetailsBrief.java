package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_initiation_soc_brief")
public class ProjectMactroDetailsBrief {	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SocId;
	private Long InitiationId;
	private String TRLanalysis;
	private String PeerReview;
	private String ActionPlan;
	private String TestingPlan;
	private String ResponsibilityMatrix;
	private String DevelopmentPartner;
	private String ProductionAgencies;
	private String CostsBenefit;
	private String ProjectManagement;
	private String PERT;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
