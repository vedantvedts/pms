package com.vts.pfms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "milestone_activity_type")
public class MilestoneActivityType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ActivityTypeId;
	private String ActivityType;
	private String CreatedDate;
	private String CreatedBy;
	private int IsActive;
	
	
	public long getActivityTypeId() {
		return ActivityTypeId;
	}
	public void setActivityTypeId(long activityTypeId) {
		ActivityTypeId = activityTypeId;
	}
	public String getActivityType() {
		return ActivityType;
	}
	public void setActivityType(String activityType) {
		ActivityType = activityType;
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
