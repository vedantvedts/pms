package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
@Data
@Entity
@Table(name="pfms_initiation_req_status")
public class PfmsReqStatus {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long StatusId;
	private Long InitiationId;
	private String Status;
	private Long ApprovalId;
	private String RequirementNumber;
	private String version;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
