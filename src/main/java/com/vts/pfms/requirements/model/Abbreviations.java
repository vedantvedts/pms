package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_abbreviations")
public class Abbreviations {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AbbreviationsId;
	private String Abbreviations;
	private String Meaning;
//	private Long InitiationId;
//	private Long projectId;
	private Long TestPlanInitiationId;
	private Long SpecsInitiationId;
	private String AbbreviationType;
}
