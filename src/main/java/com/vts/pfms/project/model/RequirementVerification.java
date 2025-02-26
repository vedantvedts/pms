package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_verification")
public class RequirementVerification {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long VerificationId;
	private String Provisions;
//	private Long InitiationId;
	private String ProvisionsDetails;
    private String CreatedBy;
    private String CreatedDate;
	private int IsActive;
//	private Long ProjectId ;
	private Long ReqInitiationId;
}
