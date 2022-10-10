package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_schedules_minutes_details")
public class CommitteeScheduleMinutesDetails {

	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ScheduleMinutesId;
	private long ScheduleId;
	private long ScheduleSubId;
	private long MinutesId;
	private long MinutesSubId;
	private long MinutesSubOfSubId;
	private String Details;
	private String IDARCK;
	private String AgendaSubHead;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String Remarks;
	public long getScheduleMinutesId() {
		return ScheduleMinutesId;
	}
	public void setScheduleMinutesId(long scheduleMinutesId) {
		ScheduleMinutesId = scheduleMinutesId;
	}
	public long getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(long scheduleId) {
		ScheduleId = scheduleId;
	}
	public long getScheduleSubId() {
		return ScheduleSubId;
	}
	public void setScheduleSubId(long scheduleSubId) {
		ScheduleSubId = scheduleSubId;
	}
	public long getMinutesId() {
		return MinutesId;
	}
	public void setMinutesId(long minutesId) {
		MinutesId = minutesId;
	}
	public long getMinutesSubId() {
		return MinutesSubId;
	}
	public void setMinutesSubId(long minutesSubId) {
		MinutesSubId = minutesSubId;
	}
	public long getMinutesSubOfSubId() {
		return MinutesSubOfSubId;
	}
	public void setMinutesSubOfSubId(long minutesSubOfSubId) {
		MinutesSubOfSubId = minutesSubOfSubId;
	}
	public String getDetails() {
		return Details;
	}
	public void setDetails(String details) {
		Details = details;
	}
	
	public String getIDARCK() {
		return IDARCK;
	}
	public void setIDARCK(String iDARCK) {
		IDARCK = iDARCK;
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
	public String getAgendaSubHead() {
		return AgendaSubHead;
	}
	public void setAgendaSubHead(String agendaSubHead) {
		AgendaSubHead = agendaSubHead;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
	
	
}
