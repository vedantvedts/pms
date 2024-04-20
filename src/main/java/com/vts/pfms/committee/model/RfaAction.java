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
@Table(name ="pfms_rfa_action")
public class RfaAction {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaId;
	private String LabCode;
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
	
	
	
}
