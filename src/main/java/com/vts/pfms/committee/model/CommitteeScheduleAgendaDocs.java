package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
