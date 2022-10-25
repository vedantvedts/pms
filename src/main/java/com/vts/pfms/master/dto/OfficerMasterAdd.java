package com.vts.pfms.master.dto;

public class OfficerMasterAdd {
 
	public String EmpId;
	public String EmpNo;
	public String EmpName;
	public String Designation;
	public String ExtNo;
	public String Email;
	public String Division;
	private String labId;
	private String SrNo;
	private String MobileNo;
	private String DronaEmail;
	private String InternalEmail;
	private String LabCode;
	
	
	
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public String getMobileNo() {
		return MobileNo;
	}
	public void setMobileNo(String mobileNo) {
		MobileNo = mobileNo;
	}
	public String getDronaEmail() {
		return DronaEmail;
	}
	public void setDronaEmail(String dronaEmail) {
		DronaEmail = dronaEmail;
	}
	public String getInternalEmail() {
		return InternalEmail;
	}
	public void setInternalEmail(String internalEmail) {
		InternalEmail = internalEmail;
	}
	public String getEmpId() {
		return EmpId;
	}
	public void setEmpId(String empId) {
		EmpId = empId;
	}
	public String getEmpNo() {
		return EmpNo;
	}
	public void setEmpNo(String empNo) {
		EmpNo = empNo;
	}
	public String getEmpName() {
		return EmpName;
	}
	public void setEmpName(String empName) {
		EmpName = empName;
	}
	public String getDesignation() {
		return Designation;
	}
	public void setDesignation(String designation) {
		Designation = designation;
	}
	public String getExtNo() {
		return ExtNo;
	}
	public void setExtNo(String extNo) {
		ExtNo = extNo;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getDivision() {
		return Division;
	}
	public void setDivision(String division) {
		Division = division;
	}
	
	public String getLabId() {
		return labId;
	}
	public void setLabId(String labId) {
		this.labId = labId;
	}
	public String getSrNo() {
		return SrNo;
	}
	public void setSrNo(String srNo) {
		SrNo = srNo;
	}
	
}
