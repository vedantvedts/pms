package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_closure_acp")
public class ProjectClosureACP implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ClosureACPId;
	private long ClosureId;
//	private String ACPAim;
//	private String ACPObjectives;
	private int Prototyes;
	private String FacilitiesCreated;
	private String MonitoringCommittee;
	private String MonitoringCommitteeAttach;
	private String CertificateFromLab;
	private String TechReportNo;
//	private String ExpndAsOn;
//	private String TotalExpnd;
//	private String TotalExpndFE;
	private String TrialResults;
//	private String ACPStatus;
//	private String ClosureStatusCode;
//	private String ClosureStatusCodeNext;
//	private String ForwardedBy;
//	private String ForwardedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
