package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_meeting_approval")
public class CommitteeMeetingApproval {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MeetingApprovalId;
	private Long ScheduleId;
	private Long EmpId;
	private String Remarks;
	private String MeetingStatus;
	private String ActionBy;
	private String ActionDate;
	public Long getMeetingApprovalId() {
		return MeetingApprovalId;
	}
	public void setMeetingApprovalId(Long meetingApprovalId) {
		MeetingApprovalId = meetingApprovalId;
	}
	public Long getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(Long scheduleId) {
		ScheduleId = scheduleId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public String getMeetingStatus() {
		return MeetingStatus;
	}
	public void setMeetingStatus(String meetingStatus) {
		MeetingStatus = meetingStatus;
	}
	public String getActionBy() {
		return ActionBy;
	}
	public void setActionBy(String actionBy) {
		ActionBy = actionBy;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	
	
	
}
