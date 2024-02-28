package com.vts.pfms.projectclosure.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProjectClosureACPDTO {
	private long ClosureACPId;
//	private long ProjectId;
	private long ClosureId;
	private String ACPAim;
	private String ACPObjectives;
	private String Prototyes;
	private String FacilitiesCreated;
	private String MonitoringCommittee;
	private String MonitoringCommitteeAttach;
	private String CertificateFromLab;
	private String TechReportNo;
	private String ExpndAsOn;
	private String TotalExpnd;
	private String TotalExpndFE;
	private String ACPStatus;
	private String ClosureStatusCode;
	private String ClosureStatusCodeNext;
	private String ForwardedBy;
	
	private String details;
	private String action;
	
	private String UserId;
	private String EmpId;
	
	private String acpProjectTypeFlag;
	private String[] ACPProjectType;
	private String[] ACPProjectName;
	private String[] ACPProjectNo;
	private String[] ProjectAgency;
	private String[] ProjectCost;
	private String[] ProjectStatus;
	private String[] ProjectAchivements;
	
	private String[] ConsultancyAim;
	private String[] ConsultancyAgency;
	private String[] ConsultancyCost;
	private String[] ConsultancyDate;
	
	private String[] Envisaged;
	private String[] Achieved;
	private String[] Remarks;
	
	private String TrialResults;
	private String[] Description;
	private String[] AttatchmentName;
	private MultipartFile[] Attachment;
	
}
