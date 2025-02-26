package com.vts.pfms.committee.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.Data;

@Data
@Entity
@Table(name="pms_enote")
public class PmsEnote {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EnoteId;
	private String RefNo;
	private Date RefDate;
	private String Subject;
	private String Comment;
	private Long CommitteeMainId;
	private Long ScheduleId;
	private Long Recommend1;
	private String Rec1_Role;
	private Long Recommend2;
	private String Rec2_Role;
	private Long Recommend3;
	private String Rec3_Role;
	private Long ApprovingOfficer;
	private String Approving_Role;
	private String ApprovingOfficerLabCode;
	private String EnoteFrom;
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
