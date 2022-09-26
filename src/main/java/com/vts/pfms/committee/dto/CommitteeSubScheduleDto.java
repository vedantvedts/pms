package com.vts.pfms.committee.dto;

public class CommitteeSubScheduleDto 
{
	private String ScheduleSubId;
	private String ScheduleId;
	private String ScheduleDate;
	private String ScheduleStartTime;	
	private String ScheduleFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
	
	
	public String getScheduleSubId() {
		return ScheduleSubId;
	}
	public String getScheduleId() {
		return ScheduleId;
	}
	public String getScheduleDate() {
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
	public String getIsActive() {
		return IsActive;
	}
	public void setScheduleSubId(String scheduleSubId) {
		ScheduleSubId = scheduleSubId;
	}
	public void setScheduleId(String scheduleId) {
		ScheduleId = scheduleId;
	}
	public void setScheduleDate(String scheduleDate) {
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
	public void setIsActive(String isActive) {
		IsActive = isActive;
	}
}
