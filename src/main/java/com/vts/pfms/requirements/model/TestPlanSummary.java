package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_test_plan_summary")
public class TestPlanSummary {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SummaryId;
//	private Long InitiationId;
	private String AdditionalInformation;
	private String Abstract;
	private String Keywords;
	private String Distribution;
	private String Reviewer;
	private Long Approver;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
//  private long ProjectId;
	private int IsActive;
	private String PreparedBy;
	private Long TestPlanInitiationId;
	private Long SpecsInitiationId;
	private String ReleaseDate;
	private String DocumentNo;
}
