package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_initiation_schedule")
public class PfmsInitiationSchedule implements Serializable {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationScheduleId;
    private Long InitiationId;
    private int MilestoneNo;
    private String MilestoneActivity;
    private int MilestoneMonth;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	private String MilestoneRemark;
	
	public String getMilestoneRemark() {
		return MilestoneRemark;
	}
	public void setMilestoneRemark(String milestoneRemark) {
		MilestoneRemark = milestoneRemark;
	}
	public Long getInitiationScheduleId() {
		return InitiationScheduleId;
	}
	public void setInitiationScheduleId(Long initiationScheduleId) {
		InitiationScheduleId = initiationScheduleId;
	}
	public Long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	
	public int getMilestoneNo() {
		return MilestoneNo;
	}
	public void setMilestoneNo(int milestoneNo) {
		MilestoneNo = milestoneNo;
	}
	public String getMilestoneActivity() {
		return MilestoneActivity;
	}
	public void setMilestoneActivity(String milestoneActivity) {
		MilestoneActivity = milestoneActivity;
	}
	public int getMilestoneMonth() {
		return MilestoneMonth;
	}
	public void setMilestoneMonth(int milestoneMonth) {
		MilestoneMonth = milestoneMonth;
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
