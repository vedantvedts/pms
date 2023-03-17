package com.vts.pfms.committee.dto;



public class ActionMainDto {
	private String ActionMainId;
	private String ActionParentId;
	private String MainId;
	private Long ActionLevel;
	private String ActionLinkId;
	private String ActionDate;
	private String StartDate;
	private String ActionItem;
	private String ProjectId;
	private String ScheduleMinutesId;
	private String Priority;
	private String Category;
	private String Type;
	private String ActionType;
	private String ActivityId;
	private String ActionStatus;
	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String MeetingDate;
	private String ScheduleId;
	private String LabName;
	private String PDCDate;

	public String getPDCDate() {
		return PDCDate;
	}
	public void setPDCDate(String pDCDate) {
		PDCDate = pDCDate;
	}
	public String getLabName() {
		return LabName;
	}
	public void setLabName(String labName) {
		LabName = labName;
	}
	public String getMainId() {
		return MainId;
	}
	public void setMainId(String mainId) {
		MainId = mainId;
	}
	public String getActionParentId() {
		return ActionParentId;
	}
	public void setActionParentId(String actionParentId) {
		ActionParentId = actionParentId;
	}
	public Long getActionLevel() {
		return ActionLevel;
	}
	public void setActionLevel(Long actionLevel) {
		ActionLevel = actionLevel;
	}
	public String getPriority() {
		return Priority;
	}
	public void setPriority(String priority) {
		Priority = priority;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	public String getMeetingDate() {
		return MeetingDate;
	}
	public void setMeetingDate(String meetingDate) {
		MeetingDate = meetingDate;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getActionLinkId() {
		return ActionLinkId;
	}
	public void setActionLinkId(String actionLinkId) {
		ActionLinkId = actionLinkId;
	}
	public String getActionMainId() {
		return ActionMainId;
	}
	public void setActionMainId(String actionMainId) {
		ActionMainId = actionMainId;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	public String getStartDate() {
		return StartDate;
	}
	public void setStartDate(String startDate) {
		StartDate = startDate;
	}
	public String getActionItem() {
		return ActionItem;
	}
	public void setActionItem(String actionItem) {
		ActionItem = actionItem;
	}
	
	public String getScheduleMinutesId() {
		return ScheduleMinutesId;
	}
	public void setScheduleMinutesId(String scheduleMinutesId) {
		ScheduleMinutesId = scheduleMinutesId;
	}
	
	public String getActionType() {
		return ActionType;
	}
	public void setActionType(String actionType) {
		ActionType = actionType;
	}
	public String getActivityId() {
		return ActivityId;
	}
	public void setActivityId(String activityId) {
		ActivityId = activityId;
	}
	public String getActionStatus() {
		return ActionStatus;
	}
	public void setActionStatus(String actionStatus) {
		ActionStatus = actionStatus;
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
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	public String getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(String scheduleId) {
		ScheduleId = scheduleId;
	}
}
