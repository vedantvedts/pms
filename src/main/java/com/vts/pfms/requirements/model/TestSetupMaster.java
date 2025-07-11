package com.vts.pfms.requirements.model;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Table(name="pfms_testsetup_master")
@Data
public class TestSetupMaster {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long setupId;
	
	private String testSetUpId;
	
	private String objective;
	
	private String testInstrument;
	
	private String facilityRequired;
	
	private String testSetUp;
	
	private String testProcedure;
	
	private String tdrsData;
	
	private int IsActive;
	private String CreatedBy;
	private LocalDateTime CreatedDate;
	private String ModifiedBy;
	private LocalDateTime ModifiedDate;
	
	
	@Transient
	private MultipartFile tdrs;
	
	@Transient
	private String labCode;
}
