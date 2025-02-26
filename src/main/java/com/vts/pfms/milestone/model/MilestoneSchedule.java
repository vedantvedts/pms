package com.vts.pfms.milestone.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="milestone_schedule")
public class MilestoneSchedule {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long MilestoneScheduleId;
	private long ProjectId;
	private int MilestoneNo;
	private long ActivityType;
	private String ActivityName;
	private Date OrgStartDate;
	private Date OrgEndDate;
	private Date StartDate;
	private Date EndDate;
	private int ProgressStatus;
	private int Weightage;
	private int ActivityStatusId;
	private Date DateOfCompletion;
	private String StatusRemarks;
	private int RevisionNo;
	private String CreatedDate;
	private String CreatedBy;
	private String ModifiedBy;
	private String ModifiedDate;
	private int isActive;
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	
	public long getMilestoneScheduleId() {
		return MilestoneScheduleId;
	}
	public void setMilestoneScheduleId(long milestoneScheduleId) {
		MilestoneScheduleId = milestoneScheduleId;
	}
	public long getProjectId() {
		return ProjectId;
	}
	public int getMilestoneNo() {
		return MilestoneNo;
	}
	public long getActivityType() {
		return ActivityType;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public Date getOrgStartDate() {
		return OrgStartDate;
	}
	public Date getOrgEndDate() {
		return OrgEndDate;
	}
	public Date getStartDate() {
		return StartDate;
	}
	public Date getEndDate() {
		return EndDate;
	}
	public int getProgressStatus() {
		return ProgressStatus;
	}
	public int getWeightage() {
		return Weightage;
	}
	
	public Date getDateOfCompletion() {
		return DateOfCompletion;
	}
	public String getStatusRemarks() {
		return StatusRemarks;
	}
	public int getRevisionNo() {
		return RevisionNo;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}

	public void setProjectId(long projectId) {
		ProjectId = projectId;
	}
	public void setMilestoneNo(int milestoneNo) {
		MilestoneNo = milestoneNo;
	}
	public void setActivityType(long activityType) {
		ActivityType = activityType;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
	}
	public void setOrgStartDate(Date orgStartDate) {
		OrgStartDate = orgStartDate;
	}
	public void setOrgEndDate(Date orgEndDate) {
		OrgEndDate = orgEndDate;
	}
	public void setStartDate(Date startDate) {
		StartDate = startDate;
	}
	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}
	public void setProgressStatus(int progressStatus) {
		ProgressStatus = progressStatus;
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
	public void setDateOfCompletion(Date dateOfCompletion) {
		DateOfCompletion = dateOfCompletion;
	}
	public void setStatusRemarks(String statusRemarks) {
		StatusRemarks = statusRemarks;
	}
	public void setRevisionNo(int revisionNo) {
		RevisionNo = revisionNo;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
	
	
}
