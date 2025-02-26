package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_abbreviations")
public class InitiationAbbreviations {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AbbreviationsId;
	private String Abbreviations;
	private String Meaning;
//	private Long InitiationId;
//	private Long ProjectId;
	private Long ReqInitiationId;
}
