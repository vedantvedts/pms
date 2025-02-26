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
@Table(name = "pfms_specification_master")
public class SpecificationMaster {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecsMasterId;
	private String SpecificationName;
	private String Description;
	private String SpecsParameter;
	private String SpecsUnit;
	private String SpecsInitiationId;
	private String SpecValue;
	private String maximumValue;
	private String minimumValue;
	private String SpecificationType;
	private int specCount;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	private Long MainId;
	private Long ParentId;
	private Long sid;


}
