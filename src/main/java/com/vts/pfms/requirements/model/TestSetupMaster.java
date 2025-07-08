package com.vts.pfms.requirements.model;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
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
}
