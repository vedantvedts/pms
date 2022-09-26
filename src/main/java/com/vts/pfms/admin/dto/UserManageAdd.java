package com.vts.pfms.admin.dto;

public class UserManageAdd {

	private String UserName;
	private String Division;
	private String Role;
	private String LoginType;
	private String Employee;
	private String LoginId;
	private String Pfms;
	
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getDivision() {
		return Division;
	}
	public void setDivision(String division) {
		Division = division;
	}
	public String getRole() {
		return Role;
	}
	public void setRole(String role) {
		Role = role;
	}
	public String getLoginType() {
		return LoginType;
	}
	public void setLoginType(String loginType) {
		LoginType = loginType;
	}
	public String getEmployee() {
		return Employee;
	}
	public void setEmployee(String employee) {
		Employee = employee;
	}
	public String getLoginId() {
		return LoginId;
	}
	public void setLoginId(String loginId) {
		LoginId = loginId;
	}
	/**
	 * @return the pfms
	 */
	public String getPfms() {
		return Pfms;
	}
	/**
	 * @param pfms the pfms to set
	 */
	public void setPfms(String pfms) {
		Pfms = pfms;
	}
	
	
	
	
}
