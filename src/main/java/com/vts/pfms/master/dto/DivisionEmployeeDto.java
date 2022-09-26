package com.vts.pfms.master.dto;

public class DivisionEmployeeDto {

	private String DivisionEmployeeId;
	private String[] EmpId;
	private String DivisionId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	public String getDivisionEmployeeId() {
		return DivisionEmployeeId;
	}
	public void setDivisionEmployeeId(String divisionEmployeeId) {
		DivisionEmployeeId = divisionEmployeeId;
	}
	
	public String[] getEmpId() {
		return EmpId;
	}
	public void setEmpId(String[] empId) {
		EmpId = empId;
	}
	public String getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(String divisionId) {
		DivisionId = divisionId;
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
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
	
}
