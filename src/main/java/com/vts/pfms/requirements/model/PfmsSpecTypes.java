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
@Table(name = "pfms_specification_types")
public class PfmsSpecTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SpecificationMainId;
	private String SpecificationName;
	private Long SpecificationParentId;
	private String SpecCode;
}
