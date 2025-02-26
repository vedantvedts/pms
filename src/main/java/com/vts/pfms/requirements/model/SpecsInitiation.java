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

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="pfms_specifications_initiation")
public class SpecsInitiation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecsInitiationId;
	private Long ProjectId;
	private Long InitiationId;
	private Long ProductTreeMainId;
	private String SpecsVersion;
	private Long InitiatedBy;
	private String InitiatedDate;
	private String ReqStatusCode;
	private String ReqStatusCodeNext;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	private String Remarks;
}
