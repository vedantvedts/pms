package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="committee_schedules_agenda")
public class CommitteeScheduleAgenda {	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ScheduleAgendaId;
	private Long ScheduleId;
	private Long ScheduleSubId;
	private String AgendaItem;
	private String PresentorLabCode;
	private Long PresenterId;
	private int Duration;
	private Long ProjectId;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int AgendaPriority;
	private int IsActive;
	private Long ParentScheduleAgendaId;
	private String FileName;
}
