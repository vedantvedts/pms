package com.vts.pfms.project.model;

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
@Table(name="pfms_initiation_sqr_para")
public class RequirementparaModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ParaId;
	private Long SqrId;
	private Long InitiationId;
	private String ParaNo;
	private String ParaDetails;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	private Long ProjectId;
}
