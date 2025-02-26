package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
    private String RiskMitigation;
    private String Proposal;
    private String RealizationPlan;
    private String WorldScenario;
	private String ReqBrief;
    private String ObjBrief;
    private String ScopeBrief;
    private String MultiLabBrief;
    private String EarlierWorkBrief;
    private String CompentencyBrief;
    private String NeedOfProjectBrief;
    private String TechnologyBrief;
    private String RiskMitigationBrief;
    private String ProposalBrief;
    private String RealizationBrief;
    private String WorldScenarioBrief;
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

	public String getRiskMitigation() {
		return RiskMitigation;
	}
	public void setRiskMitigation(String riskMitigation) {
		RiskMitigation = riskMitigation;
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
	public String getWorldScenario() {
		return WorldScenario;
	}
	public void setWorldScenario(String worldScenario) {
		WorldScenario = worldScenario;
	}
	public String getReqBrief() {
		return ReqBrief;
	}
	public void setReqBrief(String reqBrief) {
		ReqBrief = reqBrief;
	}
	public String getObjBrief() {
		return ObjBrief;
	}
	public void setObjBrief(String objBrief) {
		ObjBrief = objBrief;
	}
	public String getScopeBrief() {
		return ScopeBrief;
	}
	public void setScopeBrief(String scopeBrief) {
		ScopeBrief = scopeBrief;
	}
	public String getMultiLabBrief() {
		return MultiLabBrief;
	}
	public void setMultiLabBrief(String multiLabBrief) {
		MultiLabBrief = multiLabBrief;
	}
	public String getEarlierWorkBrief() {
		return EarlierWorkBrief;
	}
	public void setEarlierWorkBrief(String earlierWorkBrief) {
		EarlierWorkBrief = earlierWorkBrief;
	}
	public String getCompentencyBrief() {
		return CompentencyBrief;
	}
	public void setCompentencyBrief(String compentencyBrief) {
		CompentencyBrief = compentencyBrief;
	}
	public String getNeedOfProjectBrief() {
		return NeedOfProjectBrief;
	}
	public void setNeedOfProjectBrief(String needOfProjectBrief) {
		NeedOfProjectBrief = needOfProjectBrief;
	}
	public String getTechnologyBrief() {
		return TechnologyBrief;
	}
	public void setTechnologyBrief(String technologyBrief) {
		TechnologyBrief = technologyBrief;
	}
	public String getRiskMitigationBrief() {
		return RiskMitigationBrief;
	}
	public void setRiskMitigationBrief(String riskMitigationBrief) {
		RiskMitigationBrief = riskMitigationBrief;
	}
	public String getProposalBrief() {
		return ProposalBrief;
	}
	public void setProposalBrief(String proposalBrief) {
		ProposalBrief = proposalBrief;
	}
	public String getRealizationBrief() {
		return RealizationBrief;
	}
	public void setRealizationBrief(String realizationBrief) {
		RealizationBrief = realizationBrief;
	}
	public String getWorldScenarioBrief() {
		return WorldScenarioBrief;
	}
	public void setWorldScenarioBrief(String worldScenarioBrief) {
		WorldScenarioBrief = worldScenarioBrief;
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
