package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
