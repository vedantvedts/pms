package com.vts.pfms.report.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity
@Table(name="pfms_labreport_milestone")
public class PfmsLabReportMilestone {

	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	    private long MilestoneId;
		private long ProjectId;
	    private long MilestoneActivityId;
	    private String ActivityName;
	    private String ActivityFor;
		private String CreatedBy;
		private String CreatedDate;
		
		@Transient
		private String isChecked;
}
