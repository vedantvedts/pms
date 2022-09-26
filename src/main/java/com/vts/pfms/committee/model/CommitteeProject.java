package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_project")
public class CommitteeProject {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeProjectId;
	private Long ProjectId;
	private Long CommitteeId;	
	private String Description;
	private String TermsOfReference;	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public Long getCommitteeProjectId() {
		return CommitteeProjectId;
	}
	public void setCommitteeProjectId(Long committeeProjectId) {
		CommitteeProjectId = committeeProjectId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return Description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		Description = description;
	}
	/**
	 * @return the termsOfReference
	 */
	public String getTermsOfReference() {
		return TermsOfReference;
	}
	/**
	 * @param termsOfReference the termsOfReference to set
	 */
	public void setTermsOfReference(String termsOfReference) {
		TermsOfReference = termsOfReference;
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
	/**
	 * @return the modifiedBy
	 */
	public String getModifiedBy() {
		return ModifiedBy;
	}
	/**
	 * @param modifiedBy the modifiedBy to set
	 */
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	/**
	 * @return the modifiedDate
	 */
	public String getModifiedDate() {
		return ModifiedDate;
	}
	/**
	 * @param modifiedDate the modifiedDate to set
	 */
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
}
