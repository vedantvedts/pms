package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_test_plan_acceptance")
public class TestAcceptance {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TestId;
//	private Long InitiationId;
	private String Attributes;
	private String AttributesDetailas;
	private String FileName;
	private String FilePath;
	private String CreatedDate;
	private String CreatedBy;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
//	private Long ProjectId;
	@Transient
	private MultipartFile file;
	private Long TestPlanInitiationId;
}
