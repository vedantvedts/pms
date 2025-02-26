package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;


@Data
@Entity
@Table(name="pfms_initiation_verification_data")
public class VerificationData {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long VerificationDataId;
	private Long VerificationMasterId;
//	private Long ProjectId;
//	private Long InitiationId;
	private String TypeofTest;
	private String Purpose;
	private String CreatedDate;
	private String CreatedBy;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
}
