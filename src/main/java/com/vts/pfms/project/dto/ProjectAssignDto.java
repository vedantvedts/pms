package com.vts.pfms.project.dto;

public class ProjectAssignDto {

	private long ProjectEmployeeId;
	private String[] EmpId;
	private String ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	public long getProjectEmployeeId() {
		return ProjectEmployeeId;
	}
	public void setProjectEmployeeId(long projectEmployeeId) {
		ProjectEmployeeId = projectEmployeeId;
	}
	public String[] getEmpId() {
		return EmpId;
	}
	public void setEmpId(String[] empId) {
		EmpId = empId;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
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
	
	
}
