package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee")
public class Committee
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeId;
	private String CommitteeShortName;
	private String CommitteeName;
	private String CommitteeType;
	private String ProjectApplicable;
	private String TechNonTech;
	private String Guidelines;
	private String PeriodicNon;
	private int PeriodicDuration;	
	private String Description;
	private String TermsOfReference;
	private long IsGlobal;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
	
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getTermsOfReference() {
		return TermsOfReference;
	}
	public void setTermsOfReference(String termsOfReference) {
		TermsOfReference = termsOfReference;
	}
	
	public String getTechNonTech() {
		return TechNonTech;
	}
	public String getGuidelines() {
		return Guidelines;
	}
	public String getPeriodicNon() {
		return PeriodicNon;
	}
	public int getPeriodicDuration() {
		return PeriodicDuration;
	}
	public void setTechNonTech(String techNonTech) {
		TechNonTech = techNonTech;
	}
	public void setGuidelines(String guidelines) {
		Guidelines = guidelines;
	}
	public void setPeriodicNon(String periodicNon) {
		PeriodicNon = periodicNon;
	}
	public void setPeriodicDuration(int periodicDuration) {
		PeriodicDuration = periodicDuration;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
	}
	public String getCommitteeShortName() {
		return CommitteeShortName;
	}
	public void setCommitteeShortName(String committeeShortName) {
		CommitteeShortName = committeeShortName;
	}
	public String getCommitteeName() {
		return CommitteeName;
	}
	public void setCommitteeName(String committeeName) {
		CommitteeName = committeeName;
	}
	public String getCommitteeType() {
		return CommitteeType;
	}
	public void setCommitteeType(String committeeType) {
		CommitteeType = committeeType;
	}
	public String getProjectApplicable() {
		return ProjectApplicable;
	}
	public void setProjectApplicable(String projectApplicable) {
		ProjectApplicable = projectApplicable;
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
	public long getIsGlobal() {
		return IsGlobal;
	}
	public void setIsGlobal(long isGlobal) {
		IsGlobal = isGlobal;
	}
	
	

}
