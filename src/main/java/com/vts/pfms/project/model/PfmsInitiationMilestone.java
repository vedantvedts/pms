package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_ms")
public class PfmsInitiationMilestone {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long InitiationMilestoneId;
	private long InitiationId;
	private String PDRProbableDate;
	private String PDRActualDate;
	private String TIECProbableDate;
	private String TIECActualDate;
	private String CECProbableDate;
	private String CECActualDate;
	private String CCMProbableDate;
	private String CCMActualDate;
	private String DMCProbableDate;
	private String DMCActualDate;
	private String SanctionProbableDate;
	private String SanctionActualDate;
	private long Revision;
	private String SetBaseline;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;

}
