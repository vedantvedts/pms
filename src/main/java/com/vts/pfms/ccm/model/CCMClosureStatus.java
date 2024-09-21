package com.vts.pfms.ccm.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_ccm_closure")
public class CCMClosureStatus implements Serializable {

private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CCMClosureId;
	private Long ScheduleId;
	private String LabCode;
	private Long ProjectId;
	private String ProjectCode;
	private String Recommendation;
	private String TCRStatus;
	private String ACRStatus;
	private String ActivityStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
}
