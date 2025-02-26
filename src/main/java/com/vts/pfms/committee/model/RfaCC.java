package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_rfa_cc")
public class RfaCC {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaCCId;
	private Long RfaId;
	private Long CCEmpId;
	private Long ActionBy;
	private String LabCode;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	

}
