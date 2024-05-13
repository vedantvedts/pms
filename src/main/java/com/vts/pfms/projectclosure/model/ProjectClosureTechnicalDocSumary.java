package com.vts.pfms.projectclosure.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

public class ProjectClosureTechnicalDocSumary {


	@Data
	@Entity
	@Table(name="pfms_closure_technical_docsumary")
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
		private Long ProjectId;
		private String PreparedBy;
	}

	

}
