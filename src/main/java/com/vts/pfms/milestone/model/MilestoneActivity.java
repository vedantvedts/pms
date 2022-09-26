package com.vts.pfms.milestone.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="milestone_activity")
public class MilestoneActivity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MilestoneActivityId;
	private Long ProjectId;
	private int MilestoneNo;
	private Long ActivityType;
	private String ActivityName;
	private Date OrgStartDate;
	private Date OrgEndDate;
	private Date StartDate;
	private Date EndDate;
	private Long OicEmpId;
	private Long OicEmpId1;
	private int ProgressStatus;
	private int Weightage;
	private int ActivityStatusId;
	private String StatusRemarks;
	private int RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	public Long getMilestoneActivityId() {
		return MilestoneActivityId;
	}
	public void setMilestoneActivityId(Long milestoneActivityId) {
		MilestoneActivityId = milestoneActivityId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public int getMilestoneNo() {
		return MilestoneNo;
	}
	public void setMilestoneNo(int milestoneNo) {
		MilestoneNo = milestoneNo;
	}
	
	public Long getActivityType() {
		return ActivityType;
	}
	public void setActivityType(Long activityType) {
		ActivityType = activityType;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
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
	public int getProgressStatus() {
		return ProgressStatus;
	}
	public void setProgressStatus(int progressStatus) {
		ProgressStatus = progressStatus;
	}
	public int getWeightage() {
		return Weightage;
	}
	public void setWeightage(int weightage) {
		Weightage = weightage;
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
	public int getRevisionNo() {
		return RevisionNo;
	}
	public void setRevisionNo(int revisionNo) {
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
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
}
