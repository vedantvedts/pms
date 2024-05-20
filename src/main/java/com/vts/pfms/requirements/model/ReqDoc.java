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
@Table(name = "pfms_req_initiation_linkeddocs")
public class ReqDoc {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LinkedId;
	private Long DocId;
//	private Long InitiationId;
//	private Long ProjectId;
	private Long ReqInitiationId;
	private int IsActive;
}
