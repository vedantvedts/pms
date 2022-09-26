package com.vts.pfms.master.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="employee_external")
public class EmployeeExternal {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long EmpId;
	private Long LabId;
	private String EmpNo;
	private String EmpName;
	private Long DesigId;
	private String ExtNo;
	private Long MobileNo;
	private String Email;
	private String DronaEmail;
	private String InternetEmail;
	private Long DivisionId;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public Long getLabId() {
		return LabId;
	}
	public void setLabId(Long labId) {
		LabId = labId;
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
	public Long getDesigId() {
		return DesigId;
	}
	public void setDesigId(Long desigId) {
		DesigId = desigId;
	}
	public String getExtNo() {
		return ExtNo;
	}
	public void setExtNo(String extNo) {
		ExtNo = extNo;
	}
	public Long getMobileNo() {
		return MobileNo;
	}
	public void setMobileNo(Long mobileNo) {
		MobileNo = mobileNo;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getDronaEmail() {
		return DronaEmail;
	}
	public void setDronaEmail(String dronaEmail) {
		DronaEmail = dronaEmail;
	}
	public Long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(Long divisionId) {
		DivisionId = divisionId;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
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
	/**
	 * @return the internetEmail
	 */
	public String getInternetEmail() {
		return InternetEmail;
	}
	/**
	 * @param internetEmail the internetEmail to set
	 */
	public void setInternetEmail(String internetEmail) {
		InternetEmail = internetEmail;
	}
	
	
	
	
}
