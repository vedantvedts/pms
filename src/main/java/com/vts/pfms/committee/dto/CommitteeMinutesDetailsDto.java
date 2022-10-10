package com.vts.pfms.committee.dto;

public class CommitteeMinutesDetailsDto {

	private String ScheduleMinutesId;
	private String ScheduleId;
	private String ScheduleSubId;
	private String MinutesId;
	private String MinutesSubId;
	private String MinutesSubOfSubId;
	private String Details;
	private String IDARCK;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String MinutesUnitId;
	private String StatusFlag;
	private String Remarks;
	private String AgendaSubHead;
	
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public String getStatusFlag() {
		return StatusFlag;
	}
	public void setStatusFlag(String statusFlag) {
		StatusFlag = statusFlag;
	}
	public String getMinutesUnitId() {
		return MinutesUnitId;
	}
	public void setMinutesUnitId(String minutesUnitId) {
		MinutesUnitId = minutesUnitId;
	}
	public String getScheduleMinutesId() {
		return ScheduleMinutesId;
	}
	public void setScheduleMinutesId(String scheduleMinutesId) {
		ScheduleMinutesId = scheduleMinutesId;
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
	public String getMinutesId() {
		return MinutesId;
	}
	public void setMinutesId(String minutesId) {
		MinutesId = minutesId;
	}
	public String getMinutesSubId() {
		return MinutesSubId;
	}
	public void setMinutesSubId(String minutesSubId) {
		MinutesSubId = minutesSubId;
	}
	public String getMinutesSubOfSubId() {
		return MinutesSubOfSubId;
	}
	public void setMinutesSubOfSubId(String minutesSubOfSubId) {
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
