package com.vts.pfms.committee.dto;

import lombok.Data;

@Data
public class CommitteeScheduleDto 
{
	
	private Long ScheduleId;
	private String LabCode;
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
	private String rodNameId ;
	private String PMRCDecisions;
	
}
