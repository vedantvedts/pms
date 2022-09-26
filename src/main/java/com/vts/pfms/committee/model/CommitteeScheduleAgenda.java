package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="committee_schedules_agenda")
public class CommitteeScheduleAgenda {	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ScheduleAgendaId;
	private Long ScheduleId;
	private Long ScheduleSubId;
	private String AgendaItem;
	private Long PresenterId;
	private int Duration;
	private Long ProjectId;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Long CommitteeId;
	private int AgendaPriority;
	private int IsActive;
	
	public Long getScheduleAgendaId() {
		return ScheduleAgendaId;
	}
	public void setScheduleAgendaId(Long scheduleAgendaId) {
		ScheduleAgendaId = scheduleAgendaId;
	}
	public Long getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(Long scheduleId) {
		ScheduleId = scheduleId;
	}
	public Long getScheduleSubId() {
		return ScheduleSubId;
	}
	public void setScheduleSubId(Long scheduleSubId) {
		ScheduleSubId = scheduleSubId;
	}
	public String getAgendaItem() {
		return AgendaItem;
	}
	public void setAgendaItem(String agendaItem) {
		AgendaItem = agendaItem;
	}
	public Long getPresenterId() {
		return PresenterId;
	}
	public void setPresenterId(Long presenterId) {
		PresenterId = presenterId;
	}
	public int getDuration() {
		return Duration;
	}
	public void setDuration(int duration) {
		Duration = duration;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
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
	public int getAgendaPriority() {
		return AgendaPriority;
	}
	public void setAgendaPriority(int agendaPriority) {
		AgendaPriority = agendaPriority;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
	}
	
}
