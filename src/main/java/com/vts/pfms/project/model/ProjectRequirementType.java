package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
