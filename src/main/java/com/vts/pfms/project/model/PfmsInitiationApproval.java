package com.vts.pfms.project.model;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_approval")
public class PfmsInitiationApproval {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EnoteId;
	private String RefNo;
	private LocalDate RefDate;
	private String Subject;
	private String Comment;
	private Long InitiationId;
	private Long Recommend1;
	private String Rec1_Role;
	private Long Recommend2;
	private String Rec2_Role;
	private Long Recommend3;
	private String Rec3_Role;
	private Long ApprovingOfficer;
	private String Approving_Role;
	private String ApprovingOfficerLabCode;
	private String EnoteStatusCode;
	private String EnoteStatusCodeNext;
	private Long InitiatedBy;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	@Transient
	private String sessionLabCode;
}
