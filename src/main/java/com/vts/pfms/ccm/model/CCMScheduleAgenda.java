package com.vts.pfms.ccm.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_ccm_schedule_agenda")
public class CCMScheduleAgenda implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ScheduleAgendaId;
	private Long CCMScheduleId;
	private Long ParentScheduleAgendaId;
	private int AgendaPriority;
	private String AgendaItem;
	private String PresenterLabCode;
	private String PresenterId;
	private String StartTime;
	private String EndTime;
	private int Duration;
	private String AttatchmentPath;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
