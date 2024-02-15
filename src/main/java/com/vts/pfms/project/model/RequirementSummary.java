package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_summary")
public class RequirementSummary {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SummaryId;
	private Long InitiationId;
	private String AdditionalInformation;
	private String Abstract;
	private String Keywords;
	private String Distribution;
	private Long Reviewer;
	private Long Approver;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
