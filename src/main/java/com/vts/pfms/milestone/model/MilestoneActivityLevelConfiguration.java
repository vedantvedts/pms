package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="milestone_activity_level_configuration")
public class MilestoneActivityLevelConfiguration {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LevelConfigurationId;
	private Long ProjectId;
	private Long CommitteeId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Long Levelid;
	public Long getLevelid() {
		return Levelid;
	}
	public void setLevelid(Long levelid) {
		Levelid = levelid;
	}
	public Long getLevelConfigurationId() {
		return LevelConfigurationId;
	}
	public void setLevelConfigurationId(Long levelConfigurationId) {
		LevelConfigurationId = levelConfigurationId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
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
