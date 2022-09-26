package com.vts.pfms.committee.dto;

import java.util.ArrayList;

public class CommitteeMemberExternalDto {
	
	private String CommitteeExternalMemberId;
	private String CommitteeMainId;
	private ArrayList<String>  LabId;
	private ArrayList<String> EmpId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
	public String getCommitteeExternalMemberId() {
		return CommitteeExternalMemberId;
	}
	public void setCommitteeExternalMemberId(String committeeExternalMemberId) {
		CommitteeExternalMemberId = committeeExternalMemberId;
	}
	
	public String getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(String committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	

	public ArrayList<String> getLabId() {
		return LabId;
	}
	public void setLabId(ArrayList<String> labId) {
		LabId = labId;
	}
	public ArrayList<String> getEmpId() {
		return EmpId;
	}
	public void setEmpId(ArrayList<String> empId) {
		EmpId = empId;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public String getIsActive() {
		return IsActive;
	}
	public void setIsActive(String isActive) {
		IsActive = isActive;
	}
	

}
