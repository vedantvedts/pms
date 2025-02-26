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
