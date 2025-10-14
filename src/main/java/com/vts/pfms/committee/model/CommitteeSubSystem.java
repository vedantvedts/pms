package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "committee_subsystem")
public class CommitteeSubSystem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SubSystemId;
	private String SubSystem;
	private String CreatedBy;
	private String CreatedDate;

}
