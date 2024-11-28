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
@Table(name = "pfms_specification_master")
public class SpecificationMaster {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecsMasterId;
	private String SpecificationName;
	private String Description;
	private String SpecsParameter;
	private String SpecsUnit;
	private Long SpecsInitiationId;
	private String SpecValue;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;

}
