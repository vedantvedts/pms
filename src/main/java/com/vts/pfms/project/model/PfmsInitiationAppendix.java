package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
