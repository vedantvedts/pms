package com.vts.pfms.fracas.dto;

public class PfmsFracasAssignDto {
		
	private String FracasAssignId;
	private String FracasMainId; 
	private String Remarks;
	private String PDC;
	private String Assigner;
	private String[] Assignee;
	private String AssignedDate;
	private String FracasStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
	
	public String getFracasAssignId() {
		return FracasAssignId;
	}
	public String getFracasMainId() {
		return FracasMainId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public String getPDC() {
		return PDC;
	}
	public String getAssigner() {
		return Assigner;
	}
	
	public String getAssignedDate() {
		return AssignedDate;
	}
	public String getFracasStatus() {
		return FracasStatus;
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
	public String getIsActive() {
		return IsActive;
	}
	public void setFracasAssignId(String fracasAssignId) {
		FracasAssignId = fracasAssignId;
	}
	public void setFracasMainId(String fracasMainId) {
		FracasMainId = fracasMainId;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public void setPDC(String pDC) {
		PDC = pDC;
	}
	public void setAssigner(String assigner) {
		Assigner = assigner;
	}

	public void setAssignedDate(String assignedDate) {
		AssignedDate = assignedDate;
	}
	public void setFracasStatus(String fracasStatus) {
		FracasStatus = fracasStatus;
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
	public void setIsActive(String isActive) {
		IsActive = isActive;
	}
	public String[] getAssignee() {
		return Assignee;
	}
	public void setAssignee(String[] assignee) {
		Assignee = assignee;
	}
	
	

	
	
	
}
