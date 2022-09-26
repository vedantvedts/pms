package com.vts.pfms.milestone.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "file_doc_master" )
public class FileDocMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FileUploadMasterId;
	private int ParentLevelId;
	private int LevelId;
	private String LevelName;
	private String DocShortName;
	private Long DocId;
	private String CreatedDate;
	private String CreatedBy; 
	private int IsActive;
	
	public long getFileUploadMasterId() {
		return FileUploadMasterId;
	}
	public void setFileUploadMasterId(long fileUploadMasterId) {
		FileUploadMasterId = fileUploadMasterId;
	}
	public int getParentLevelId() {
		return ParentLevelId;
	}
	public void setParentLevelId(int parentLevelId) {
		ParentLevelId = parentLevelId;
	}
	public int getLevelId() {
		return LevelId;
	}
	public void setLevelId(int levelId) {
		LevelId = levelId;
	}
	public String getLevelName() {
		return LevelName;
	}
	public void setLevelName(String levelName) {
		LevelName = levelName;
	}
	public String getDocShortName() {
		return DocShortName;
	}
	public void setDocShortName(String docShortName) {
		DocShortName = docShortName;
	}
	public long getDocId() {
		return DocId;
	}
	public void setDocId(long docId) {
		DocId = docId;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	} 
	
	
}
