package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_initiation_detail")
public class PfmsInitiationDetail implements Serializable {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long InitiationDetailId;
	private Long InitiationId;
    private String Requirements;
    private String Objective;
    private String Scope;
    private String MultiLabWorkShare;
    private String EarlierWork;
    private String CompentencyEstablished;
    private String NeedOfProject;
    private String TechnologyChallanges;
    private String RiskMitiagation;
    private String Proposal;
    private String RealizationPlan;

    
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	public Long getInitiationDetailId() {
		return InitiationDetailId;
	}
	public void setInitiationDetailId(Long initiationDetailId) {
		InitiationDetailId = initiationDetailId;
	}
	public Long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	public String getRequirements() {
		return Requirements;
	}
	public void setRequirements(String requirements) {
		Requirements = requirements;
	}
	public String getObjective() {
		return Objective;
	}
	public void setObjective(String objective) {
		Objective = objective;
	}
	public String getScope() {
		return Scope;
	}
	public void setScope(String scope) {
		Scope = scope;
	}
	public String getMultiLabWorkShare() {
		return MultiLabWorkShare;
	}
	public void setMultiLabWorkShare(String multiLabWorkShare) {
		MultiLabWorkShare = multiLabWorkShare;
	}
	public String getEarlierWork() {
		return EarlierWork;
	}
	public void setEarlierWork(String earlierWork) {
		EarlierWork = earlierWork;
	}
	public String getCompentencyEstablished() {
		return CompentencyEstablished;
	}
	public void setCompentencyEstablished(String compentencyEstablished) {
		CompentencyEstablished = compentencyEstablished;
	}
	public String getNeedOfProject() {
		return NeedOfProject;
	}
	public void setNeedOfProject(String needOfProject) {
		NeedOfProject = needOfProject;
	}
	public String getTechnologyChallanges() {
		return TechnologyChallanges;
	}
	public void setTechnologyChallanges(String technologyChallanges) {
		TechnologyChallanges = technologyChallanges;
	}
	public String getRiskMitiagation() {
		return RiskMitiagation;
	}
	public void setRiskMitiagation(String riskMitiagation) {
		RiskMitiagation = riskMitiagation;
	}
	public String getProposal() {
		return Proposal;
	}
	public void setProposal(String proposal) {
		Proposal = proposal;
	}
	public String getRealizationPlan() {
		return RealizationPlan;
	}
	public void setRealizationPlan(String realizationPlan) {
		RealizationPlan = realizationPlan;
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
