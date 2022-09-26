package com.vts.pfms.milestone.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="file_rep_new")
public class FileRepNew {			
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long FileRepId;
    private Long ProjectId;
	private Long FileRepMasterId;
	private Long VersionDoc;
	private Long ReleaseDoc;
	private Long DocumentId;
	private Long SubL1;
	
	
	public Long getSubL1() {
		return SubL1;
	}
	public void setSubL1(Long subL1) {
		SubL1 = subL1;
	}
	
	public Long getDocumentId() {
		return DocumentId;
	}
	public void setDocumentId(Long documentId) {
		DocumentId = documentId;
	}
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	public Long getFileRepId() {
		return FileRepId;
	}
	public void setFileRepId(Long fileRepositoryId) {
		FileRepId = fileRepositoryId;
	}
	
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}

	public Long getFileRepMasterId() {
		return FileRepMasterId;
	}
	public void setFileRepMasterId(Long fileRepMasterId) {
		FileRepMasterId = fileRepMasterId;
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
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public Long getVersionDoc() {
		return VersionDoc;
	}
	public void setVersionDoc(Long versionDoc) {
		VersionDoc = versionDoc;
	}
	public Long getReleaseDoc() {
		return ReleaseDoc;
	}
	public void setReleaseDoc(Long releaseDoc) {
		ReleaseDoc = releaseDoc;
	}
	
	
}
