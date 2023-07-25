package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
@Data
@Entity
@Table(name="pfms_initiation_req_Approval")
public class PfmsRequirementApproval implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	 private Long ReqApprovalId;
	 private Long InitiationId;
	 private String EmpId;
	 private String Remarks;
	 private String ReqStatus;
	 private String ActionBy;
	 private String ActionDate;
}
