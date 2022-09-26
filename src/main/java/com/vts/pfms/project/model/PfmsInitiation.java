package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_initiation")
public class PfmsInitiation implements Serializable {

	

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long InitiationId;
	private Long EmpId;
    private Long DivisionId;
    private String ProjectProgramme;
    private Long ProjectTypeId;
    private Long CategoryId;
    private String ProjectShortName;
    private String ProjectTitle;
    private Double ProjectCost;
    private Double FeCost;
    private Double ReCost;
    private int ProjectDuration;
    private String IsPlanned;
    private String IsMultiLab;
    private int LabCount;
    private String Deliverable;
    private String ProjectStatus;
    private String IsMain;
    private Long MainId;
    private Long NodalLab;
    private String Remarks;
    private Long PCDuration;
    private Double IndicativeCost;
    private String PCRemarks;
    
    
	public Long getPCDuration() {
		return PCDuration;
	}
	public void setPCDuration(Long pCDuration) {
		PCDuration = pCDuration;
	}
	public Double getIndicativeCost() {
		return IndicativeCost;
	}
	public void setIndicativeCost(Double indicativeCost) {
		IndicativeCost = indicativeCost;
	}

	public String getPCRemarks() {
		return PCRemarks;
	}
	public void setPCRemarks(String pCRemarks) {
		PCRemarks = pCRemarks;
	}
	public String getIsMain() {
		return IsMain;
	}
	public Long getMainId() {
		return MainId;
	}
	public Long getNodalLab() {
		return NodalLab;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setIsMain(String isMain) {
		IsMain = isMain;
	}
	public void setMainId(Long mainId) {
		MainId = mainId;
	}
	public void setNodalLab(Long nodalLab) {
		NodalLab = nodalLab;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public String getProjectStatus() {
		return ProjectStatus;
	}
	public void setProjectStatus(String projectStatus) {
		ProjectStatus = projectStatus;
	}
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	
	public Long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public Long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(Long divisionId) {
		DivisionId = divisionId;
	}
	public String getProjectProgramme() {
		return ProjectProgramme;
	}
	public void setProjectProgramme(String projectProgramme) {
		ProjectProgramme = projectProgramme;
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
	public String getProjectShortName() {
		return ProjectShortName;
	}
	public void setProjectShortName(String projectShortName) {
		ProjectShortName = projectShortName;
	}
	public String getProjectTitle() {
		return ProjectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		ProjectTitle = projectTitle;
	}
	public Double getProjectCost() {
		return ProjectCost;
	}
	public void setProjectCost(Double projectCost) {
		ProjectCost = projectCost;
	}
	public int getProjectDuration() {
		return ProjectDuration;
	}
	public void setProjectDuration(int projectDuration) {
		ProjectDuration = projectDuration;
	}
	public String getIsPlanned() {
		return IsPlanned;
	}
	public void setIsPlanned(String isPlanned) {
		IsPlanned = isPlanned;
	}
	public String getIsMultiLab() {
		return IsMultiLab;
	}
	public void setIsMultiLab(String isMultiLab) {
		IsMultiLab = isMultiLab;
	}
	public int getLabCount() {
		return LabCount;
	}
	public void setLabCount(int labCount) {
		LabCount = labCount;
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
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public Double getFeCost() {
		return FeCost;
	}
	public void setFeCost(Double feCost) {
		FeCost = feCost;
	}
	public Double getReCost() {
		return ReCost;
	}
	public void setReCost(Double reCost) {
		ReCost = reCost;
	}
	
	
	
	
    
	
}
