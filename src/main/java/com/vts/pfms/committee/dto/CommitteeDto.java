package com.vts.pfms.committee.dto;

public class CommitteeDto {

	private Long CommitteeId;
	
	private String CommitteeShortName;
	private String CommitteeName;
	private String CommitteeType;
	private String ProjectApplicable;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String TechNonTech;
	private String Guidelines;
	private String PeriodicNon;
	private String PeriodicDuration;
	private String Description;
	private String TermsOfReference;
	private String IsGlobal;
	
	
	
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
	public void setTechNonTech(String techNonTech) {
		TechNonTech = techNonTech;
	}
	public String getGuidelines() {
		return Guidelines;
	}
	public void setGuidelines(String guidelines) {
		Guidelines = guidelines;
	}
	public String getPeriodicNon() {
		return PeriodicNon;
	}
	public void setPeriodicNon(String periodicNon) {
		PeriodicNon = periodicNon;
	}
	public String getPeriodicDuration() {
		return PeriodicDuration;
	}
	public void setPeriodicDuration(String periodicDuration) {
		PeriodicDuration = periodicDuration;
	}
	private int IsActive;
	
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
	public String getIsGlobal() {
		return IsGlobal;
	}
	public void setIsGlobal(String isGlobal) {
		IsGlobal = isGlobal;
	}
	
}

