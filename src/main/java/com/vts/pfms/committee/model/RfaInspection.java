package com.vts.pfms.committee.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name ="pfms_rfa_inspection")
public class RfaInspection {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaInspectionId;
	private String LabCode;
	private Long RfaId;
	private String RfaNo;
	private Date CompletionDate;
	private String Observation;
	private String Clarification;
	private String ActionRequired;
	private Long EmpId;
	private String RfaStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

	
}
