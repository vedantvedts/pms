package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_req_types")
public class PfmsReqTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RequirementId;
	private String ReqName;
	private Long ReqParentId;
	private String ReqCode;
}
