package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_testplan_master")
public class TestPlanMaster {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TestMasterId;
	
	private String Name;
	private String Objective;
	private String Description;
	private String PreConditions;
	private String PostConditions;
	private String Constraints;
	private String SafetyRequirements;
	//private String TestParameterSpecId;
	private String Methodology;
	private String ToolsSetup;
	private String  PersonnelResources;
	private String EstimatedTimeIteration;
	private String Iterations;
	private String Schedule;
	private String Pass_Fail_Criteria;
	private String Remarks;
//	private Long InitiationId;
//	private Long ProjectId;
	private String StageApplicable;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	


}
