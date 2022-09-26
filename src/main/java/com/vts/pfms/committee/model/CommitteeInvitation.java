package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private long LabId;
	private long SerialNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	public long getLabId() {
		return LabId;
	}

	public void setLabId(long labId) {
		LabId = labId;
	}

	public long getCommitteeInvitationId() {
		return CommitteeInvitationId;
	}
	
	public long getCommitteeScheduleId() {
		return CommitteeScheduleId;
	}
	public long getEmpId() {
		return EmpId;
	}
	public String getMemberType() {
		return MemberType;
	}
	public String getAttendance() {
		return Attendance;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setCommitteeInvitationId(long committeeInvitationId) {
		CommitteeInvitationId = committeeInvitationId;
	}
	
	public void setCommitteeScheduleId(long committeeScheduleId) {
		CommitteeScheduleId = committeeScheduleId;
	}
	public void setEmpId(long empId) {
		EmpId = empId;
	}
	public void setMemberType(String memberType) {
		MemberType = memberType;
	}
	public void setAttendance(String attendance) {
		Attendance = attendance;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}

	public String getDesigId() {
		return DesigId;
	}

	public void setDesigId(String desigId) {
		DesigId = desigId;
	}

	public long getSerialNo() {
		return SerialNo;
	}

	public void setSerialNo(long serialNo) {
		SerialNo = serialNo;
	}
	
	
	
	

}
