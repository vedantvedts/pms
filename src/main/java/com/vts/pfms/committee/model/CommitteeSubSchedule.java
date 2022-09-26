package com.vts.pfms.committee.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_schedule_sub")
public class CommitteeSubSchedule 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ScheduleSubId;
	private long ScheduleId;
	private Date ScheduleDate;
	private String ScheduleStartTime;	
	private String ScheduleFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
	public long getScheduleSubId() {
		return ScheduleSubId;
	}
	public long getScheduleId() {
		return ScheduleId;
	}
	public Date getScheduleDate() {
		return ScheduleDate;
	}
	public String getScheduleStartTime() {
		return ScheduleStartTime;
	}
	public String getScheduleFlag() {
		return ScheduleFlag;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setScheduleSubId(long scheduleSubId) {
		ScheduleSubId = scheduleSubId;
	}
	public void setScheduleId(long scheduleId) {
		ScheduleId = scheduleId;
	}
	public void setScheduleDate(Date scheduleDate) {
		ScheduleDate = scheduleDate;
	}
	public void setScheduleStartTime(String scheduleStartTime) {
		ScheduleStartTime = scheduleStartTime;
	}
	public void setScheduleFlag(String scheduleFlag) {
		ScheduleFlag = scheduleFlag;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
}
