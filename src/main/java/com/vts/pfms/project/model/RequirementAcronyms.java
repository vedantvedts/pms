package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_acronyms")
public class RequirementAcronyms {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AcronymsId;
	
	private String Acronyms;
	
	private String Definition;
	
//	private Long InitiationId;
	
	private int IsActive;
//	private Long ProjectId;
	private Long ReqInitiationId;
	
}
