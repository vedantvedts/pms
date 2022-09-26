package com.vts.pfms.milestone.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="file_rep_master")
public class FileRepMaster {			
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long FileRepMasterId;
    private Long ProjectId;
    private Long ParentLevelId;
	private Long LevelId;
	private String LevelName;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

	public Long getFileRepMasterId() {
		return FileRepMasterId;
	}
	public void setFileRepMasterId(Long fileRepMasterId) {
		FileRepMasterId = fileRepMasterId;
	}
	public Long getParentLevelId() {
		return ParentLevelId;
	}
	public void setParentLevelId(Long parentLevelId) {
		ParentLevelId = parentLevelId;
	}
	public Long getLevelId() {
		return LevelId;
	}
	public void setLevelId(Long levelId) {
		LevelId = levelId;
	}
	public String getLevelName() {
		return LevelName;
	}
	public void setLevelName(String levelName) {
		LevelName = levelName;
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
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
			
}
