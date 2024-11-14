package com.vts.pfms.report.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
		private String CreatedBy;
		private String CreatedDate;
		
		@Transient
		private String isChecked;
}
