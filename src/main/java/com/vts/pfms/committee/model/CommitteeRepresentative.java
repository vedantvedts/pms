package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="committee_rep")
public class CommitteeRepresentative {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RepId;
	private String RepCode;
	private String RepName;
	private String CreatedBy;
	private String CreatedDate;
	
}
