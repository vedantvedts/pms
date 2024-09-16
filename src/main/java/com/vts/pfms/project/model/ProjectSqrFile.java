package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_initiation_sqr")
public class ProjectSqrFile {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SqrId;
//	private Long InitiationId;
	private String QRType;
	private String Title;
	private  String User;
	private String RefNo;
	private String SqrNo;
	private String PreviousSqrNo;
	private String MeetingReference;
	private String PriorityDevelopment;
	private String Authority;
	private String FileName;
	private String FilePath;
	private Double Version;
	private String CreatedDate;
	private String CreatedBy;
	private int IsActive;
	private Long ReqInitiationId;
	
}
