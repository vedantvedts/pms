package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Builder
@AllArgsConstructor
@Data
@Entity
@Table(name = "committee_default_agenda")
public class CommitteeDefaultAgenda {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long DefaultAgendaId;
	private String LabCode;
	private long CommitteeId;
	private int AgendaPriority;
	private String AgendaItem;
	private int Duration;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
