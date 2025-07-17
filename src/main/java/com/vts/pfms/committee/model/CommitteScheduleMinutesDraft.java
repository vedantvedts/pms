package com.vts.pfms.committee.model;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name ="committee_schedules_mom_draft")
public class CommitteScheduleMinutesDraft {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long draftId;
	private Long scheduleId;
	private Long empid;
	private LocalDate sentDate;
	private String sentBy;
	
}
