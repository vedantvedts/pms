package com.vts.pfms.ms.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="cluster_committee_schedule")
public class ClusterCommitteeSchedule {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ClusterScheduleId;
	private Long ScheduleId;
	private String LabCode;
	private Long CommitteeId;
	private Long CommitteeMainId;
	private String MeetingId;
	private Long ProjectId;
	private Long DivisionId; 
	private Long InitiationId; 
	private Long CARSInitiationId;
	private Long RODNameId;
	private Date ScheduleDate;
	private String ScheduleStartTime;
	private String ScheduleFlag;
	private String ScheduleSub;
	private String KickOffOtp;
	private String MeetingVenue;
	private String Confidential;
	private String Reference;
	private String PMRCDecisions;
	private String BriefingPaperFrozen;
	private String MinutesFrozen;
	private String PresentationFrozen;
	private String BriefingStatus;
	private String ScheduleType;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
