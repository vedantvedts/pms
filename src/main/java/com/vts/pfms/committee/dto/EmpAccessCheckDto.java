package com.vts.pfms.committee.dto;

public class EmpAccessCheckDto {

	
	public EmpAccessCheckDto(String logintype, String scheduleid, String empid, Object committeemainid,
			int committeecons, String confidential) {
		super();
		this.logintype = logintype;
		this.scheduleid = scheduleid;
		this.empid = empid;
		this.committeemainid = committeemainid;
		this.committeecons = committeecons;
		this.confidential = confidential;
	}
	
	String logintype;
	String scheduleid ;
	String empid;
	Object committeemainid;
	int committeecons;
	String confidential;
	public String getLogintype() {
		return logintype;
	}
	public void setLogintype(String logintype) {
		this.logintype = logintype;
	}
	public String getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(String scheduleid) {
		this.scheduleid = scheduleid;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public Object getCommitteemainid() {
		return committeemainid;
	}
	public void setCommitteemainid(Object committeemainid) {
		this.committeemainid = committeemainid;
	}
	public int getCommitteecons() {
		return committeecons;
	}
	public void setCommitteecons(int committeecons) {
		this.committeecons = committeecons;
	}
	public String getConfidential() {
		return confidential;
	}
	public void setConfidential(String confidential) {
		this.confidential = confidential;
	}
	
	
	
}
