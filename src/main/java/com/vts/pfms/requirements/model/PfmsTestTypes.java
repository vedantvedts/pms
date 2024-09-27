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
@Table(name = "pfms_test_types")
public class PfmsTestTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long testMainId;
	private String testName;
	private Long testParentId;
	private String testCode;
}
