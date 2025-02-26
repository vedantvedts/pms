package com.vts.pfms.milestone.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="milestone_activity_level")
public class MilestoneActivityLevel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActivityId;
	private Long ParentActivityId;
	private Long ActivityLevelId;
	private String ActivityName;
	private Long ActivityType;
	private Date OrgStartDate;
	private Date OrgEndDate;
	private Date StartDate;
	private Date EndDate;
	private Long OicEmpId;
	private Long OicEmpId1;
	private Long Revision;
	private int ProgressStatus;	
	private int ActivityStatusId;
	private String StatusRemarks;
	private int Weightage;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String point5;
	private String point6;
	private String point9;
	
	public Long getActivityId() {
		return ActivityId;
	}
	public void setActivityId(Long activityId) {
		ActivityId = activityId;
	}
	public Long getParentActivityId() {
		return ParentActivityId;
	}
	public void setParentActivityId(Long parentActivityId) {
		ParentActivityId = parentActivityId;
	}
	public Long getActivityLevelId() {
		return ActivityLevelId;
	}
	public void setActivityLevelId(Long activityLevelId) {
		ActivityLevelId = activityLevelId;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
	}
	
	public Long getActivityType() {
		return ActivityType;
	}
	public void setActivityType(Long activityType) {
		ActivityType = activityType;
	}
	public Date getOrgStartDate() {
		return OrgStartDate;
	}
	public void setOrgStartDate(Date orgStartDate) {
		OrgStartDate = orgStartDate;
	}
	public Date getOrgEndDate() {
		return OrgEndDate;
	}
	public void setOrgEndDate(Date orgEndDate) {
		OrgEndDate = orgEndDate;
	}
	public Date getStartDate() {
		return StartDate;
	}
	public void setStartDate(Date startDate) {
		StartDate = startDate;
	}
	public Date getEndDate() {
		return EndDate;
	}
	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}
     
	public Long getOicEmpId() {
		return OicEmpId;
	}
	public void setOicEmpId(Long oicEmpId) {
		OicEmpId = oicEmpId;
	}
	public Long getOicEmpId1() {
		return OicEmpId1;
	}
	public void setOicEmpId1(Long oicEmpId1) {
		OicEmpId1 = oicEmpId1;
	}
	public Long getRevision() {
		return Revision;
	}
	public void setRevision(Long revision) {
		Revision = revision;
	}
	public int getProgressStatus() {
		return ProgressStatus;
	}
	public void setProgressStatus(int progressStatus) {
		ProgressStatus = progressStatus;
	}
	public int getActivityStatusId() {
		return ActivityStatusId;
	}
	public void setActivityStatusId(int activityStatusId) {
		ActivityStatusId = activityStatusId;
	}
	public String getStatusRemarks() {
		return StatusRemarks;
	}
	public void setStatusRemarks(String statusRemarks) {
		StatusRemarks = statusRemarks;
	}
	/**
	 * @return the weightage
	 */
	public int getWeightage() {
		return Weightage;
	}
	/**
	 * @param weightage the weightage to set
	 */
	public void setWeightage(int weightage) {
		Weightage = weightage;
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
