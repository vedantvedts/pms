package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	

}
