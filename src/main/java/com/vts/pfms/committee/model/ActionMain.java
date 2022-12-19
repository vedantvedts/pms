package com.vts.pfms.committee.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="action_main")
public class ActionMain {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionMainId;
	private Long ParentActionId;
	private Long MainId;
	private Long ActionLevel;
	private Date ActionDate;
	private String ActionItem;
	private Long ProjectId;
	private Long ScheduleMinutesId;
	private String Type;
	private String Priority;
	private String Category;
	private String ActionType;
	private Long ActivityId;
	private Long ActionLinkId;
	private String Remarks;
	//private String ActionStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

	
	
	public Long getMainId() {
		return MainId;
	}
	public void setMainId(Long mainId) {
		MainId = mainId;
	}
	public Long getParentActionId() {
		return ParentActionId;
	}
	public void setParentActionId(Long parentActionId) {
		ParentActionId = parentActionId;
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
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public Long getActionMainId() {
		return ActionMainId;
	}
	public void setActionMainId(Long actionMainId) {
		ActionMainId = actionMainId;
	}
	public Long getActionLinkId() {
		return ActionLinkId;
	}
	public void setActionLinkId(Long actionLinkId) {
		ActionLinkId = actionLinkId;
	}
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	public Date getActionDate() {
		return ActionDate;
	}
	public void setActionDate(Date actionDate) {
		ActionDate = actionDate;
	}
	public String getActionItem() {
		return ActionItem;
	}
	public void setActionItem(String actionItem) {
		ActionItem = actionItem;
	}
	public Long getScheduleMinutesId() {
		return ScheduleMinutesId;
	}
	public void setScheduleMinutesId(Long scheduleMinutesId) {
		ScheduleMinutesId = scheduleMinutesId;
	}
	public String getActionType() {
		return ActionType;
	}
	public void setActionType(String actionType) {
		ActionType = actionType;
	}
	public Long getActivityId() {
		return ActivityId;
	}
	public void setActivityId(Long activityId) {
		ActivityId = activityId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String sendBackRemarks) {
		Remarks = sendBackRemarks;
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
//	public String getActionStatus() {
//		return ActionStatus;
//	}
//	public void setActionStatus(String actionStatus) {
//		ActionStatus = actionStatus;
//	}
	
}
