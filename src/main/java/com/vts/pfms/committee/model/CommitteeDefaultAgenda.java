package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
