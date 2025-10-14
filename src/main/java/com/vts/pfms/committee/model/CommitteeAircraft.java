package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "committee_aircraft")
public class CommitteeAircraft {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AircraftId;
	private String Aircraft;
	private String CreatedBy;
	private String CreatedDate;

}
