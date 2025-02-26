package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "committee_constitution_approval")
public class CommitteeConstitutionApproval {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ConstitutionApprovalId;
	private long CommitteeMainId;
	private long EmpLabid;
	private long Empid;
	private String Remarks;
	private String ConstitutionStatus;
	private String ApprovalAuthority;
	private long  ConstitutedBy; 
	private String ActionBy;
	private String ActionDate;
	public long getConstitutionApprovalId() {
		return ConstitutionApprovalId;
	}
	public void setConstitutionApprovalId(long constitutionApprovalId) {
		ConstitutionApprovalId = constitutionApprovalId;
	}
	public long getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(long committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public long getEmpLabid() {
		return EmpLabid;
	}
	public void setEmpLabid(long empLabid) {
		EmpLabid = empLabid;
	}
	public long getEmpid() {
		return Empid;
	}
	public void setEmpid(long empid) {
		Empid = empid;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	
	public String getApprovalAuthority() {
		return ApprovalAuthority;
	}
	public void setApprovalAuthority(String approvalAuthority) {
		ApprovalAuthority = approvalAuthority;
	}
	public String getActionBy() {
		return ActionBy;
	}
	public void setActionBy(String actionBy) {
		ActionBy = actionBy;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	public long getConstitutedBy() {
		return ConstitutedBy;
	}
	public void setConstitutedBy(long constitutedBy) {
		ConstitutedBy = constitutedBy;
	}
	public String getConstitutionStatus() {
		return ConstitutionStatus;
	}
	public void setConstitutionStatus(String constitutionStatus) {
		ConstitutionStatus = constitutionStatus;
	}
	
	

}
