package com.vts.pfms.committee.dto;

import java.util.ArrayList;

public class CommitteeInvitationDto {



	private String CommitteeInvitationId;
	private String CommitteeScheduleId;
	private ArrayList<String> EmpIdList;
	private String Attendance;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private ArrayList<String> LabId;
	private ArrayList<String> desigids;
	private String reptype;
	
	
	public String getReptype() {
		return reptype;
	}

	public void setReptype(String reptype) {
		this.reptype = reptype;
	}

	public String getCommitteeInvitationId() {
		return CommitteeInvitationId;
	}
	
	public ArrayList<String> getLabId() {
		return LabId;
	}

	public void setLabId(ArrayList<String> labId) {
		LabId = labId;
	}

	public String getCommitteeScheduleId() {
		return CommitteeScheduleId;
	}
	public ArrayList<String> getEmpIdList() {
		return EmpIdList;
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
	public void setCommitteeInvitationId(String committeeInvitationId) {
		CommitteeInvitationId = committeeInvitationId;
	}
	
	public void setCommitteeScheduleId(String committeeScheduleId) {
		CommitteeScheduleId = committeeScheduleId;
	}
	public void setEmpIdList(ArrayList<String> empIdList) {
		EmpIdList = empIdList;
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

	public ArrayList<String> getDesigids() {
		return desigids;
	}

	public void setDesigids(ArrayList<String> desigids) {
		this.desigids = desigids;
	}
	
	
	
	
	
}
