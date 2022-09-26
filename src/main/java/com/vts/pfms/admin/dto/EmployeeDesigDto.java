package com.vts.pfms.admin.dto;

public class EmployeeDesigDto {
		
	private String DesigId;
	private String DesigCode;
	private String Designation;
	private String DesigLimit;
	private String DesigSr;
	private String OldDesigSr;
	public String getDesigSr() {
		return DesigSr;
	}
	public void setDesigSr(String desigSr) {
		DesigSr = desigSr;
	}
	public String getDesigId() {
		return DesigId;
	}
	public String getDesigCode() {
		return DesigCode;
	}
	public String getDesignation() {
		return Designation;
	}
	public String getDesigLimit() {
		return DesigLimit;
	}
	public void setDesigId(String desigId) {
		DesigId = desigId;
	}
	public void setDesigCode(String desigCode) {
		DesigCode = desigCode;
	}
	public void setDesignation(String designation) {
		Designation = designation;
	}
	public void setDesigLimit(String desigLimit) {
		DesigLimit = desigLimit;
	}
	public String getOldDesigSr() {
		return OldDesigSr;
	}
	public void setOldDesigSr(String oldDesigSr) {
		OldDesigSr = oldDesigSr;
	}
	
	
	
	
}
