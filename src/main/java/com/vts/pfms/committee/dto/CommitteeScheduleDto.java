package com.vts.pfms.committee.dto;

public class CommitteeScheduleDto 
{
	
	private Long ScheduleId;
	private Long CommitteeId;
	private Long CommitteeMainId;
	private String ScheduleDate;
	private String ScheduleStartTime;
	private String ScheduleFlag;
	private String ScheduleSub;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String ProjectId;
	private String IsActive;
	private String KickOffOtp;
	private String MeetingVenue;
	private String Confidential;
	private String MeetingId;
	private String Referrence;
	private String DivisionId;
	private String InitiationId ;
	private String PMRCDecisions;

	
	
	public String getPMRCDecisions() {
		return PMRCDecisions;
	}
	public void setPMRCDecisions(String pMRCDecisions) {
		PMRCDecisions = pMRCDecisions;
	}
	public String getReferrence() {
		return Referrence;
	}
	public void setReferrence(String referrence) {
		Referrence = referrence;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		this.ProjectId = projectId;
	}
	public String getKickOffOtp() {
		return KickOffOtp;
	}
	public void setKickOffOtp(String kickOffOtp) {
		KickOffOtp = kickOffOtp;
	}
	public Long getScheduleId() {
		return ScheduleId;
	}
	public Long getCommitteeId() {
		return CommitteeId;
	}
	public Long getCommitteeMainId() {
		return CommitteeMainId;
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
	public String getScheduleSub() {
		return ScheduleSub;
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
	public void setScheduleId(Long scheduleId) {
		ScheduleId = scheduleId;
	}
	public void setCommitteeId(Long committeeId) {
		CommitteeId = committeeId;
	}
	public void setCommitteeMainId(Long committeeMainId) {
		CommitteeMainId = committeeMainId;
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
	public void setScheduleSub(String scheduleSub) {
		ScheduleSub = scheduleSub;
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
	public String getMeetingVenue() {
		return MeetingVenue;
	}
	public void setMeetingVenue(String meetingVenue) {
		MeetingVenue = meetingVenue;
	}
	public String getConfidential() {
		return Confidential;
	}
	public void setConfidential(String confidential) {
		Confidential = confidential;
	}
	public String getMeetingId() {
		return MeetingId;
	}
	public void setMeetingId(String meetingId) {
		MeetingId = meetingId;
	}
	public String getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(String divisionId) {
		DivisionId = divisionId;
	}
	public String getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(String initiationId) {
		InitiationId = initiationId;
	}	

}
