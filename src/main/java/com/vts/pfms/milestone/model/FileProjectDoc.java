package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "file_project_doc")
public class FileProjectDoc {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ProjectDocId;
	private long Projectid;
	private long FileUploadMasterId;
	private long ParentLevelid;
	private String CreatedBy;
	private String CreatedDate;
	
	
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
	private int IsActive;
	
	
	public long getProjectDocId() {
		return ProjectDocId;
	}
	public void setProjectDocId(long projectDocId) {
		ProjectDocId = projectDocId;
	}
	public long getProjectid() {
		return Projectid;
	}
	public void setProjectid(long projectid) {
		Projectid = projectid;
	}
	public long getFileUploadMasterId() {
		return FileUploadMasterId;
	}
	public void setFileUploadMasterId(long fileUploadMasterId) {
		FileUploadMasterId = fileUploadMasterId;
	}
	public long getParentLevelid() {
		return ParentLevelid;
	}
	public void setParentLevelid(long parentLevelid) {
		ParentLevelid = parentLevelid;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
	
}
