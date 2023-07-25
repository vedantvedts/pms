package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_otherreq_details")
public class ProjectOtherReqModel implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RequirementId;
	private Long InitiationId;
	private Long ReqMainId;
	private Long ReqParentId;
	private String RequirementName;
	private String RequirementDetails;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
