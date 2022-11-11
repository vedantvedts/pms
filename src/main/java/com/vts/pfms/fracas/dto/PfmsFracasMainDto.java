package com.vts.pfms.fracas.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PfmsFracasMainDto {
	private String  FracasMainId;
	private String LabCode;
	private String FracasNo;
	private String  FracasTypeId;
	private String FracasItem;
	private String FracasDate;
	private String  ProjectId;
	private String FracasFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private MultipartFile FracasMainAttach;
	private int IsActive;
	private String FracasMainAttachId; 
	
	
	
	
}
