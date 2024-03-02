package com.vts.pfms.committee.model;



import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
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
	private long RODNameId;
	private String PresentationFrozen;

}
