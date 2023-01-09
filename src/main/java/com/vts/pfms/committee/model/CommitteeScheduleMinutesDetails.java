package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="committee_schedules_minutes_details")
public class CommitteeScheduleMinutesDetails {


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

}
