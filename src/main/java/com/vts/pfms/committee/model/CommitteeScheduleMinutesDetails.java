package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
	private Long AirCraftId;
	private Long SubSystemId;

}
