package com.vts.pfms.committee.model;

import java.sql.Date;

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
	private String ActionNo;
	private String ActionDate;
	private Date EndDate;
	private Date PDCOrg;
	private Date PDC1;
	private Date PDC2;
	private int Revision;
	private Long Assignor;
	private Long Assignee;
	private String ActionItem;
	private Long ProjectId;
	private Long ScheduleMinutesId;
	private String Type;
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	private String ActionType;
	private Long ActivityId;
	private Long ActionLinkId;
	private String Remarks;
	private String ActionStatus;
	private String ActionFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
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
	
	
	public String getActionNo() {
		return ActionNo;
	}
	public void setActionNo(String actionNo) {
		ActionNo = actionNo;
	}
	public Long getActionLinkId() {
		return ActionLinkId;
	}
	public void setActionLinkId(Long actionLinkId) {
		ActionLinkId = actionLinkId;
	}
	public Date getEndDate() {
		return EndDate;
	}
	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}
	public Long getAssignor() {
		return Assignor;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	public void setAssignor(Long assignor) {
		Assignor = assignor;
	}
	public Long getAssignee() {
		return Assignee;
	}
	public void setAssignee(Long assignee) {
		Assignee = assignee;
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
	public String getActionStatus() {
		return ActionStatus;
	}
	public void setActionStatus(String actionStatus) {
		ActionStatus = actionStatus;
	}
	public String getActionFlag() {
		return ActionFlag;
	}
	public void setActionFlag(String actionFlag) {
		ActionFlag = actionFlag;
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
	public int getRevision() {
		return Revision;
	}
	public void setRevision(int revision) {
		Revision = revision;
	}
	public Date getPDCOrg() {
		return PDCOrg;
	}
	public void setPDCOrg(Date pDCOrg) {
		PDCOrg = pDCOrg;
	}
	public Date getPDC1() {
		return PDC1;
	}
	public void setPDC1(Date pDC1) {
		PDC1 = pDC1;
	}
	public Date getPDC2() {
		return PDC2;
	}
	public void setPDC2(Date pDC2) {
		PDC2 = pDC2;
	}
	
}
