package com.vts.pfms.admin.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "employee_desig")
public class EmployeeDesig {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long DesigId;
	private String DesigCode;
	private String Designation;
	private long DesigLimit;
	
	
	public long getDesigId() {
		return DesigId;
	}
	public String getDesigCode() {
		return DesigCode;
	}
	public String getDesignation() {
		return Designation;
	}
	public long getDesigLimit() {
		return DesigLimit;
	}
	public void setDesigId(long desigId) {
		DesigId = desigId;
	}
	public void setDesigCode(String desigCode) {
		DesigCode = desigCode;
	}
	public void setDesignation(String designation) {
		Designation = designation;
	}
	public void setDesigLimit(long desigLimit) {
		DesigLimit = desigLimit;
	}
		
}
