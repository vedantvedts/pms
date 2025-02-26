package com.vts.pfms.projectclosure.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_closure_technical_docsumary")
public class ProjectClosureTechnicalDocSumary {

		
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long SummaryId;
		private Long ClosureId;
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
		private Long ProjectId;
		private String PreparedBy;
		
	}

	


