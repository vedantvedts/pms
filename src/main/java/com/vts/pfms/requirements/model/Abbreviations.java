package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
