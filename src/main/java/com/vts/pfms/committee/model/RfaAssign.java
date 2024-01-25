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
@Table(name ="pfms_rfa_assign")
public class RfaAssign {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaAssignId;
	private String LabCode;
	private Long RfaId;
	private Long Assigneeid;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
