package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
