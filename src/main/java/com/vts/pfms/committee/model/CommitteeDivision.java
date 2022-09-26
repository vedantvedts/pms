package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "committee_division")
public class CommitteeDivision {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeDivisionId;
	private Long DivisionId;
	private Long CommitteeId;	
	private String Description;
	private String TermsOfReference;	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	public Long getCommitteeDivisionId() {
		return CommitteeDivisionId;
	}
	public void setCommitteeDivisionId(Long committeeDivisionId) {
		CommitteeDivisionId = committeeDivisionId;
	}
	
	public Long getDivisionId() {
		return DivisionId;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public String getDescription() {
		return Description;
	}
	public String getTermsOfReference() {
		return TermsOfReference;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	
	public void setDivisionId(Long divisionId) {
		DivisionId = divisionId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public void setTermsOfReference(String termsOfReference) {
		TermsOfReference = termsOfReference;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	

}
