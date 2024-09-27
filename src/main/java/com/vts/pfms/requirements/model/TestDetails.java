package com.vts.pfms.requirements.model;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.vts.pfms.projectclosure.model.ProjectClosureACP;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_testdetails")
public class TestDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TestId;
	private String TestDetailsId;
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
	private String SpecificationId;
	private String StageApplicable;
	private Long RequirementId;
	private int TestCount;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Long TestPlanInitiationId;
	private Long parentId;
	private Long MainId;
	
}
