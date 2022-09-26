package com.vts.pfms.committee.dto;

public class CommitteeMainDto {

	private String CommitteeMainId;
	private String CommitteeId;
	private String ValidFrom;
	private String ValidTo;
	private String CpLabId;
	private String Chairperson;
	private String Secretary;
	private String ProxySecretary;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
	private String ProjectId;
	private String DivisionId;
	private String InitiationId;
	private String[] reps;
	private String CreatedByEmpid;
	private String CreatedByEmpidLabid;
	private String PreApproved;
	
	
	public String[] getReps() {
		return reps;
	}
	public void setReps(String[] reps) {
		this.reps = reps;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(String committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	
	public String getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(String committeeId) {
		CommitteeId = committeeId;
	}
	public String getValidFrom() {
		return ValidFrom;
	}
	public void setValidFrom(String validFrom) {
		ValidFrom = validFrom;
	}
	public String getValidTo() {
		return ValidTo;
	}
	public void setValidTo(String validTo) {
		ValidTo = validTo;
	}
	public String getChairperson() {
		return Chairperson;
	}
	public void setChairperson(String chairperson) {
		Chairperson = chairperson;
	}
	public String getSecretary() {
		return Secretary;
	}
	public void setSecretary(String secretary) {
		Secretary = secretary;
	}
	public String getProxySecretary() {
		return ProxySecretary;
	}
	public void setProxySecretary(String proxySecretary) {
		ProxySecretary = proxySecretary;
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
	public String getIsActive() {
		return IsActive;
	}
	public void setIsActive(String isActive) {
		IsActive = isActive;
	}
	/**
	 * @return the cpLabId
	 */
	public String getCpLabId() {
		return CpLabId;
	}
	/**
	 * @param cpLabId the cpLabId to set
	 */
	public void setCpLabId(String cpLabId) {
		CpLabId = cpLabId;
	}
	public String getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(String divisionId) {
		DivisionId = divisionId;
	}
	public String getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(String initiationId) {
		InitiationId = initiationId;
	}
	public String getCreatedByEmpid() {
		return CreatedByEmpid;
	}
	public void setCreatedByEmpid(String createdByEmpid) {
		CreatedByEmpid = createdByEmpid;
	}
	public String getCreatedByEmpidLabid() {
		return CreatedByEmpidLabid;
	}
	public void setCreatedByEmpidLabid(String createdByEmpidLabid) {
		CreatedByEmpidLabid = createdByEmpidLabid;
	}
	public String getPreApproved() {
		return PreApproved;
	}
	public void setPreApproved(String preApproved) {
		PreApproved = preApproved;
	}
	
	
	
}
