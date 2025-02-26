package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="committee_member_rep")
public class CommitteeMemberRep {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long MemberRepId;
	private long CommitteeMainId;
	private int RepId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	public long getMemberRepId() {
		return MemberRepId;
	}
	public void setMemberRepId(long memberRepId) {
		MemberRepId = memberRepId;
	}
	public long getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(long committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public int getRepId() {
		return RepId;
	}
	public void setRepId(int repId) {
		RepId = repId;
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
