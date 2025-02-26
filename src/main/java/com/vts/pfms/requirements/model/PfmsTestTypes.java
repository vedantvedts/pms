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
@Table(name = "pfms_test_types")
public class PfmsTestTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long testMainId;
	private String testName;
	private Long testParentId;
	private String testCode;
}
