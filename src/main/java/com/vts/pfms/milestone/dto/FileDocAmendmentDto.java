package com.vts.pfms.milestone.dto;

import java.io.InputStream;

import lombok.Data;

@Data
public class FileDocAmendmentDto {

	private String FileRepUploadId;
	private String FileName;
	private String Description;
	private String AmendVersion;
	private String FilePath;
	private String FilePass;
	private String CreatedBy;
	private String CreatedDate;
	private String ProjectId;
	private InputStream InStream;
	private String LabCode;
		
}
