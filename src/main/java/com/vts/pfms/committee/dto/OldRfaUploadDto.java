package com.vts.pfms.committee.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OldRfaUploadDto {
	
	private Long RfaFileUploadId;
	private String LabCode;
	private Long ProjectId;
	private String ProjecCode;
	private String RfaNo;
	private String RfaDate;
	private MultipartFile RfaFile;
	private MultipartFile ClosureFile;
	private String Path;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
