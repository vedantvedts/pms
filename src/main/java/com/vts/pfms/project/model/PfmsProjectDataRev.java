package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_project_data_rev")
public class PfmsProjectDataRev {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private long ProjectDataRevId;
	private long ProjectId;
	private String FilesPath;
	private String SystemConfigImgName;
	private String SystemSpecsFileName;
	private String ProductTreeImgName;
	private String PEARLImgName;
	private int CurrentStageId;
	private long RevisionNo;
	private String RevisionDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	

	public long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(long projectId) {
		ProjectId = projectId;
	}
	public String getFilesPath() {
		return FilesPath;
	}
	public void setFilesPath(String filesPath) {
		FilesPath = filesPath;
	}
	public String getSystemConfigImgName() {
		return SystemConfigImgName;
	}
	public void setSystemConfigImgName(String systemConfigImgName) {
		SystemConfigImgName = systemConfigImgName;
	}
	public String getSystemSpecsFileName() {
		return SystemSpecsFileName;
	}
	public void setSystemSpecsFileName(String systemSpecsFileName) {
		SystemSpecsFileName = systemSpecsFileName;
	}
	public String getProductTreeImgName() {
		return ProductTreeImgName;
	}
	public void setProductTreeImgName(String productTreeImgName) {
		ProductTreeImgName = productTreeImgName;
	}
	public String getPEARLImgName() {
		return PEARLImgName;
	}
	public void setPEARLImgName(String pEARLImgName) {
		PEARLImgName = pEARLImgName;
	}
	public int getCurrentStageId() {
		return CurrentStageId;
	}
	public void setCurrentStageId(int currentStageId) {
		CurrentStageId = currentStageId;
	}
	public long getRevisionNo() {
		return RevisionNo;
	}
	public void setRevisionNo(long revisionNo) {
		RevisionNo = revisionNo;
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
	public long getProjectDataRevId() {
		return ProjectDataRevId;
	}
	public void setProjectDataRevId(long projectDataRevId) {
		ProjectDataRevId = projectDataRevId;
	}
	public String getRevisionDate() {
		return RevisionDate;
	}
	public void setRevisionDate(String revisionDate) {
		RevisionDate = revisionDate;
	}
	
	

}
