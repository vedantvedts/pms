package com.vts.pfms.committee.model;



	import java.sql.Date;

import javax.persistence.Entity;
	import javax.persistence.GeneratedValue;
	import javax.persistence.GenerationType;
	import javax.persistence.Id;
	import javax.persistence.Table;

	@Entity
	@Table(name="committee_schedule")
	public class CommitteeSchedule
	{
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long ScheduleId;
		private String LabCode;
		private Long CommitteeId;
		private Long CommitteeMainId;
		private Date ScheduleDate;
		private String ScheduleStartTime;
		private String ScheduleFlag;
		private String ScheduleSub;
		private String CreatedBy;
		private String CreatedDate;
		private String ModifiedBy;
		private String ModifiedDate;
		private long ProjectId;
		private int IsActive;
		private String KickOffOtp;
		private String MeetingId;
		private String MeetingVenue;
		private int Confidential;
		private long DivisionId; 
		private long InitiationId; 
		private String PresentationFrozen;
		

		
		public String getPresentationFrozen() {
			return PresentationFrozen;
		}
		public void setPresentationFrozen(String presentationFrozen) {
			PresentationFrozen = presentationFrozen;
		}
		public String getMeetingId() {
			return MeetingId;
		}
		public void setMeetingId(String meetingId) {
			MeetingId = meetingId;
		}
		public String getLabCode() {
			return LabCode;
		}
		public void setLabCode(String labCode) {
			LabCode = labCode;
		}
		public long getProjectId() {
			return ProjectId;
		}
		public void setProjectId(long projectId) {
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
		public Date getScheduleDate() {
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
		public int getIsActive() {
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
		public void setScheduleDate(Date date) {
			ScheduleDate = date;
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
		public void setIsActive(int isActive) {
			IsActive = isActive;
		}
		public String getMeetingVenue() {
			return MeetingVenue;
		}
		public void setMeetingVenue(String meetingVenue) {
			MeetingVenue = meetingVenue;
		}
		public int getConfidential() {
			return Confidential;
		}
		public void setConfidential(int confidential) {
			Confidential = confidential;
		}
		public long getDivisionId() {
			return DivisionId;
		}
		public void setDivisionId(long divisionId) {
			DivisionId = divisionId;
		}
		public long getInitiationId() {
			return InitiationId;
		}
		public void setInitiationId(long initiationId) {
			InitiationId = initiationId;
		}	
}
