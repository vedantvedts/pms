package com.vts.pfms.project.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "project_main")
public class ProjectMain implements Serializable{


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ProjectMainId;
	private Long ProjectTypeId;
	private Long CategoryId;
	private String ProjectCode;
    private String ProjectName;
    private String ProjectDescription;
    private String UnitCode;
    private String SanctionNo;
    private Date SanctionDate;
    private Double TotalSanctionCost;
    private Double SanctionCostRE;
    private Double SanctionCostFE;
	private Date PDC;
    private Long ProjectDirector;
    private String ProjSancAuthority;
    private String BoardReference;
    private Long RevisionNo;
    private String WorkCenter;
    private String Objective;
    private String Deliverable;
    private String LabParticipating;
    private String Scope;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private int isActive;
    private int IsMainWC;
    
	public int getIsMainWC() {
		return IsMainWC;
	}
	public void setIsMainWC(int isMainWC) {
		IsMainWC = isMainWC;
	}
	public Long getProjectMainId() {
		return ProjectMainId;
	}
	public void setProjectMainId(Long projectMainId) {
		ProjectMainId = projectMainId;
	}
	public Long getProjectTypeId() {
		return ProjectTypeId;
	}
	public void setProjectTypeId(Long projectTypeId) {
		ProjectTypeId = projectTypeId;
	}
	
	public Long getCategoryId() {
		return CategoryId;
	}
	public void setCategoryId(Long categoryId) {
		CategoryId = categoryId;
	}
	public String getProjectCode() {
		return ProjectCode;
	}
	public void setProjectCode(String projectCode) {
		ProjectCode = projectCode;
	}
	public String getProjectName() {
		return ProjectName;
	}
	public void setProjectName(String projectName) {
		ProjectName = projectName;
	}
	public String getProjectDescription() {
		return ProjectDescription;
	}
	public void setProjectDescription(String projectDescription) {
		ProjectDescription = projectDescription;
	}
	public String getUnitCode() {
		return UnitCode;
	}
	public void setUnitCode(String unitCode) {
		UnitCode = unitCode;
	}
	public String getSanctionNo() {
		return SanctionNo;
	}
	public void setSanctionNo(String sanctionNo) {
		SanctionNo = sanctionNo;
	}

	public Double getTotalSanctionCost() {
		return TotalSanctionCost;
	}
	public void setTotalSanctionCost(Double totalSanctionCost) {
		TotalSanctionCost = totalSanctionCost;
	}
	public Double getSanctionCostRE() {
		return SanctionCostRE;
	}
	public void setSanctionCostRE(Double sanctionCostRE) {
		SanctionCostRE = sanctionCostRE;
	}
	public Double getSanctionCostFE() {
		return SanctionCostFE;
	}
	public void setSanctionCostFE(Double sanctionCostFE) {
		SanctionCostFE = sanctionCostFE;
	}
	public Long getProjectDirector() {
		return ProjectDirector;
	}
	public void setProjectDirector(Long projectDirector) {
		ProjectDirector = projectDirector;
	}
	public String getProjSancAuthority() {
		return ProjSancAuthority;
	}
	public void setProjSancAuthority(String projSancAuthority) {
		ProjSancAuthority = projSancAuthority;
	}
	public String getBoardReference() {
		return BoardReference;
	}
	public void setBoardReference(String boardReference) {
		BoardReference = boardReference;
	}
	public Long getRevisionNo() {
		return RevisionNo;
	}
	public void setRevisionNo(Long revisionNo) {
		RevisionNo = revisionNo;
	}
	public String getWorkCenter() {
		return WorkCenter;
	}
	public void setWorkCenter(String workCenter) {
		WorkCenter = workCenter;
	}
	public String getObjective() {
		return Objective;
	}
	public void setObjective(String objective) {
		Objective = objective;
	}
	public String getDeliverable() {
		return Deliverable;
	}
	public void setDeliverable(String deliverable) {
		Deliverable = deliverable;
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
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	public Date getSanctionDate() {
		return SanctionDate;
	}
	public void setSanctionDate(Date sanctionDate) {
		SanctionDate = sanctionDate;
	}
	public Date getPDC() {
		return PDC;
	}
	public void setPDC(Date pDC) {
		PDC = pDC;
	}
	public String getLabParticipating() {
		return LabParticipating;
	}
	public void setLabParticipating(String nodal) {
		LabParticipating = nodal;
	}
	
	
	public String getScope() {
		return Scope;
	}
	public void setScope(String scope) {
		Scope = scope;
	}
	public String toString() {
		return "ProjectMain [ProjectMainId=" + ProjectMainId + ", ProjectTypeId=" + ProjectTypeId + ", CategoryId="
				+ CategoryId + ", ProjectCode=" + ProjectCode + ", ProjectName=" + ProjectName + ", ProjectDescription="
				+ ProjectDescription + ", UnitCode=" + UnitCode + ", SanctionNo=" + SanctionNo + ", SanctionDate="
				+ SanctionDate + ", TotalSanctionCost=" + TotalSanctionCost + ", SanctionCostRE=" + SanctionCostRE
				+ ", SanctionCostFE=" + SanctionCostFE + ", PDC=" + PDC + ", ProjectDirector=" + ProjectDirector
				+ ", ProjSancAuthority=" + ProjSancAuthority + ", BoardReference=" + BoardReference + ", RevisionNo="
				+ RevisionNo + ", WorkCenter=" + WorkCenter + ", Objective=" + Objective + ", Deliverable="
				+ Deliverable + ", LabParticipating=" + LabParticipating + ", CreatedBy=" + CreatedBy + ", CreatedDate="
				+ CreatedDate + ", ModifiedBy=" + ModifiedBy + ", ModifiedDate=" + ModifiedDate + ", isActive="
				+ isActive + ", IsMainWC=" + IsMainWC + "]";
	}
	
}
