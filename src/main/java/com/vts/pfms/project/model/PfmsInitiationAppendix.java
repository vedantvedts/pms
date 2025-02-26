package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_appendix")
public class PfmsInitiationAppendix {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AppendixId;
	private String AppendixName;
	private String AppendixDetails;
	private Long InitiationId;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
