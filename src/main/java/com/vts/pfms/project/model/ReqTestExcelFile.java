package com.vts.pfms.project.model;

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
@Table(name = "pfms_initiation_req_testverification")
public class ReqTestExcelFile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TestVerificationId;
//	private Long InitiationId;
	private String FileName;
	private String FilePath;
	private String CreatedDate;
	private String CreatedBy;
	private int IsActive;
//	private Long ProjectId;
	private Long ReqInitiationId;
	
	@Transient
	private MultipartFile file;
}
