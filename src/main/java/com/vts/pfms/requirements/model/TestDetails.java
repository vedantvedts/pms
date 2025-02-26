package com.vts.pfms.requirements.model;
import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

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
	private String Timetype;
	private Long TestPlanInitiationId;
	private Long parentId;
	private Long MainId;
	
}
