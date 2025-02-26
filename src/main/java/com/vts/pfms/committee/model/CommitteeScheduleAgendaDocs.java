package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "committee_schedule_agenda_docs")
public class CommitteeScheduleAgendaDocs {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AgendaDocid;
	private Long AgendaId;
	private Long FileDocId;
	private Integer IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	
}
