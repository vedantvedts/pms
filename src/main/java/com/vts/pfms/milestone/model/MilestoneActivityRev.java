package com.vts.pfms.milestone.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="milestone_activity_rev")
public class MilestoneActivityRev {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MilestoneActivityRevId;
	private Long MilestoneActivityId;
	private String ActivityName;
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
	private int IsActive;
	public Long getMilestoneActivityRevId() {
		return MilestoneActivityRevId;
	}
	public void setMilestoneActivityRevId(Long milestoneActivityRevId) {
		MilestoneActivityRevId = milestoneActivityRevId;
	}
	public Long getMilestoneActivityId() {
		return MilestoneActivityId;
	}
	public void setMilestoneActivityId(Long milestoneActivityId) {
		MilestoneActivityId = milestoneActivityId;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
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
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
}
