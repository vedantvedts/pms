package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_initiation_req_type")
public class ProjectRequirementType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReqTypeId;
	private String ReqTypeCode;
	private String ReqType;
	private String FrNr;
}
