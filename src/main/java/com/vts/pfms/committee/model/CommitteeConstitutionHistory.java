package com.vts.pfms.committee.model;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "committee_constitution_history")
public class CommitteeConstitutionHistory {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CommitteeHistoryId;
	private long ConstitutionApprovalId;
	private long CommitteeMainId;
	private String ConstitutionStatus;
	private String Remarks;
	private long ActionByLabid;
	private long ActionByEmpid;
	private String ActionDate;
	
	
	public long getCommitteeHistoryId() {
		return CommitteeHistoryId;
	}
	public long getConstitutionApprovalId() {
		return ConstitutionApprovalId;
	}
	public long getCommitteeMainId() {
		return CommitteeMainId;
	}
	public String getConstitutionStatus() {
		return ConstitutionStatus;
	}
	public String getRemarks() {
		return Remarks;
	}
	
	public String getActionDate() {
		return ActionDate;
	}
	public void setCommitteeHistoryId(long committeeHistoryId) {
		CommitteeHistoryId = committeeHistoryId;
	}
	public void setConstitutionApprovalId(long constitutionApprovalId) {
		ConstitutionApprovalId = constitutionApprovalId;
	}
	public void setCommitteeMainId(long committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public void setConstitutionStatus(String constitutionStatus) {
		ConstitutionStatus = constitutionStatus;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	public long getActionByLabid() {
		return ActionByLabid;
	}
	public long getActionByEmpid() {
		return ActionByEmpid;
	}
	public void setActionByLabid(long actionByLabid) {
		ActionByLabid = actionByLabid;
	}
	public void setActionByEmpid(long actionByEmpid) {
		ActionByEmpid = actionByEmpid;
	}
	
	

}
