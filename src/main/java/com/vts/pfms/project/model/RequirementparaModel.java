package com.vts.pfms.project.model;

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
@Table(name="pfms_initiation_sqr_para")
public class RequirementparaModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ParaId;
	private Long SqrId;
//	private Long InitiationId;
	private String ParaNo;
	private String ParaDetails;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
//	private Long ProjectId;
	private Long ReqInitiationId;
	
	private Long SINo;
}
