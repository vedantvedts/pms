package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_performance")
public class RequirementPerformanceParameters {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private Long PerformanceId;
	
	private String KeyEffectiveness;
	
	private String KeyValues;
	
//	private Long InitiationId;
	
	private int IsActive;
//	private Long ProjectId;
	private Long ReqInitiationId;
	
	
}
