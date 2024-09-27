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
@Table(name = "pfms_specification_types")
public class PfmsSpecTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecificationMainId;
	private String SpecificationName;
	private Long SpecificationParentId;
	private String SpecCode;
}
