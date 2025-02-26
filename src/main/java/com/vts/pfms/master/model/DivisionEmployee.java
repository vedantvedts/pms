package com.vts.pfms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="division_employee")
public class DivisionEmployee {	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long DivisionEmployeeId;
	private Long EmpId;
	private Long DivisionId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	public Long getDivisionEmployeeId() {
		return DivisionEmployeeId;
	}
	public void setDivisionEmployeeId(Long divisionEmployeeId) {
		DivisionEmployeeId = divisionEmployeeId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public Long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(Long divisionId) {
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