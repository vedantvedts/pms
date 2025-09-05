package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="committee")
public class Committee
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeId;
	private String LabCode;
	private String CommitteeShortName;
	private String CommitteeName;
	private String CommitteeType;
	private String ProjectApplicable;
	private String TechNonTech;
	private String Guidelines;
	private String PeriodicNon;
	private int PeriodicDuration;	
	private String Description;
	private String TermsOfReference;
	private long IsGlobal;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String IsBriefing;
	
	
	

}
