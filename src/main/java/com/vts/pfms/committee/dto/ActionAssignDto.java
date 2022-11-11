package com.vts.pfms.committee.dto;

public class ActionAssignDto {

	private Long ActionAssignId;
	private Long ActionMainId;
	private String ActionNo;
	private String ActionDate;
	private String ActionType;
	private String ScheduleId;
	private String ProjectId;
	private String EndDate;
	private String PDCOrg;
	private String PDC1;
	private String PDC2;
	private int Revision;
	private String AssignorLabCode;
	private Long Assignor;
	private String AssigneeLabCode;
	private Long Assignee;
	private String Remarks;
	private String ActionStatus;
	private String ActionFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsSeen;
	private int IsActive;
	private String [] AssigneeList;
	private String MeetingDate;
	
	
	public String getMeetingDate() {
		return MeetingDate;
	}
	public void setMeetingDate(String meetingDate) {
		MeetingDate = meetingDate;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	public String getActionType() {
		return ActionType;
	}
	public void setActionType(String actionType) {
		ActionType = actionType;
	}

	public String getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(String scheduleId) {
		ScheduleId = scheduleId;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public Long getActionAssignId() {
		return ActionAssignId;
	}
	public void setActionAssignId(Long actionAssignId) {
		ActionAssignId = actionAssignId;
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
	public String getEndDate() {
		return EndDate;
	}
	public void setEndDate(String endDate) {
		EndDate = endDate;
	}
	public String getPDCOrg() {
		return PDCOrg;
	}
	public void setPDCOrg(String pDCOrg) {
		PDCOrg = pDCOrg;
	}
	public String getPDC1() {
		return PDC1;
	}
	public void setPDC1(String pDC1) {
		PDC1 = pDC1;
	}
	public String getPDC2() {
		return PDC2;
	}
	public void setPDC2(String pDC2) {
		PDC2 = pDC2;
	}
	public int getRevision() {
		return Revision;
	}
	public void setRevision(int revision) {
		Revision = revision;
	}
	public String getAssignorLabCode() {
		return AssignorLabCode;
	}
	public void setAssignorLabCode(String assignorLabCode) {
		AssignorLabCode = assignorLabCode;
	}
	public Long getAssignor() {
		return Assignor;
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
	public String getAssigneeLabCode() {
		return AssigneeLabCode;
	}
	public void setAssigneeLabCode(String assigneeLabCode) {
		AssigneeLabCode = assigneeLabCode;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
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
	public int getIsSeen() {
		return IsSeen;
	}
	public void setIsSeen(int isSeen) {
		IsSeen = isSeen;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public String[] getAssigneeList() {
		return AssigneeList;
	}
	public void setAssigneeList(String[] assigneeList) {
		AssigneeList = assigneeList;
	}
	

	
}
