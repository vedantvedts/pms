package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_risk_rev")
public class PfmsRiskRev implements Serializable{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long RiskRevisionId;
	private Long ProjectId;
    private Long ActionMainId;
    private String Description;
    private String Severity;
    private String Probability;
    private String MitigationPlans;
    private Long RevisionNo;
    private String RevisionDate;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    
    
	public Long getRiskRevisionId() {
		return RiskRevisionId;
	}
	public void setRiskRevisionId(Long riskRevisionId) {
		RiskRevisionId = riskRevisionId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public Long getActionMainId() {
		return ActionMainId;
	}
	public void setActionMainId(Long actionMainId) {
		ActionMainId = actionMainId;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getSeverity() {
		return Severity;
	}
	public void setSeverity(String severity) {
		Severity = severity;
	}
	public String getProbability() {
		return Probability;
	}
	public void setProbability(String probability) {
		Probability = probability;
	}
	public String getMitigationPlans() {
		return MitigationPlans;
	}
	public void setMitigationPlans(String mitigationPlans) {
		MitigationPlans = mitigationPlans;
	}
	public Long getRevisionNo() {
		return RevisionNo;
	}
	public void setRevisionNo(Long revisionNo) {
		RevisionNo = revisionNo;
	}
	public String getRevisionDate() {
		return RevisionDate;
	}
	public void setRevisionDate(String revisionDate) {
		RevisionDate = revisionDate;
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
    
	
}
