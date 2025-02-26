package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
@Table(name = "pfms_initiation_ms_rev")
public class PfmsInitiationMilestoneRev {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long InitiationMileRevId;
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
	private String Remarks;
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;

}
