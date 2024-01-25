package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_verification")
public class RequirementVerification {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long VerificationId;
	private String Provisions;
	private Long InitiationId;
	private String ProvisionsDetails;
    private String CreatedBy;
    private String CreatedDate;
	private int IsActive;
}
