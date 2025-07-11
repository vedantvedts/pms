package com.vts.pfms.committee.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name ="pfms_rfa_action")
public class RfaAction {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaId;
	private String LabCode;
	private String ProjectType;
	private Long ProjectId;
	private String RfaNo;
	private Date RfaDate;
	private String RfaTypeId;
	private Long PriorityId;
	private String Statement;
	private String Description;
	private String Reference;
	private String AssignorId;
	private String RfaStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String TypeOfRfa;
	private String VendorCode;
	
	private String BoxNo;
	
	private Date SWdate;
	
	private String FPGA;
	
	private String RigVersion;
	private String RfaRaisedByName;
	
	
}
