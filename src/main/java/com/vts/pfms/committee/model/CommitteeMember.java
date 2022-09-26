package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_member")
public class CommitteeMember {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeMemberId;
	private Long CommitteeMainId;
	private Long EmpId;
	private Long LabId;
	private String MemberType;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
	
	public Long getLabId() {
		return LabId;
	}
	public void setLabId(Long labId) {
		LabId = labId;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public Long getCommitteeMemberId() {
		return CommitteeMemberId;
	}
	public void setCommitteeMemberId(Long committeeMemberId) {
		CommitteeMemberId = committeeMemberId;
	}
	public Long getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(Long committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
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
	public String getMemberType() {
		return MemberType;
	}
	public void setMemberType(String memberType) {
		MemberType = memberType;
	}
	
	
	
}
