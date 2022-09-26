package com.vts.pfms.committee.dto;



public class CommitteeScheduleAgendaDto {

	private String ScheduleAgendaId;
	private String ScheduleId;
	private String ScheduleSubId;
	private String AgendaItem;
	private String PresenterId;
	private String Duration;
	private String ProjectId;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String IsActive;
//	private String AttachmentName;
//	private byte[] AgendaAttachment;
//	private String DocId;
	private String[] DocLinkIds;
	
	
	
	public String getScheduleAgendaId() {
		return ScheduleAgendaId;
	}
	public void setScheduleAgendaId(String scheduleAgendaId) {
		ScheduleAgendaId = scheduleAgendaId;
	}
	public String getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(String scheduleId) {
		ScheduleId = scheduleId;
	}
	public String getScheduleSubId() {
		return ScheduleSubId;
	}
	public void setScheduleSubId(String scheduleSubId) {
		ScheduleSubId = scheduleSubId;
	}
	public String getAgendaItem() {
		return AgendaItem;
	}
	public void setAgendaItem(String agendaItem) {
		AgendaItem = agendaItem;
	}
	public String getPresenterId() {
		return PresenterId;
	}
	public void setPresenterId(String presenterId) {
		PresenterId = presenterId;
	}
	public String getDuration() {
		return Duration;
	}
	public void setDuration(String duration) {
		Duration = duration;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
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
	public String getIsActive() {
		return IsActive;
	}
	public void setIsActive(String isActive) {
		IsActive = isActive;
	}
	
	public String[] getDocLinkIds() {
		return DocLinkIds;
	}
	public void setDocLinkIds(String[] docLinkIds) {
		DocLinkIds = docLinkIds;
	}
		
	
}
