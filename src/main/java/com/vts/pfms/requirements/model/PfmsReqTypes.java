package com.vts.pfms.requirements.model;

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
@Table(name = "pfms_req_types")
public class PfmsReqTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RequirementId;
	private String ReqName;
	private Long ReqParentId;
	private String ReqCode;
}
