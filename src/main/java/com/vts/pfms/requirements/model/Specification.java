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
@Table(name = "pfms_specification_Details")
public class Specification  {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecsId;
	private String SpecificationName;
	private String Description;
	private Long SpecsInitiationId;
	private String LinkedRequirement;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
