package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "committee_schedules_mom_draft_remarks")
public class CommitteeSchedulesMomDraftRemarks {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long remarksId;
	
	private Long scheduleId;
	
	private Long empid;
	
	private String remarks;
	
	private String createdDate;
	
	private int isactive;
	
}