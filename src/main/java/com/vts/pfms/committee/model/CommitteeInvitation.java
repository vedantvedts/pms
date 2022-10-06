package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name= "committee_schedules_invitation")
public class CommitteeInvitation 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CommitteeInvitationId;

	private long CommitteeScheduleId;
	private long EmpId;
	private String MemberType;
	private String Attendance;
	private String DesigId;
	private String MemberLabCode;
	private long SerialNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	

}
