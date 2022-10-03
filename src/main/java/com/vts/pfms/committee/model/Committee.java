package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	
	
	

}
