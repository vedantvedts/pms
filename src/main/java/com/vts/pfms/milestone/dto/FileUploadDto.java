package com.vts.pfms.milestone.dto;

import java.io.InputStream;

import lombok.Data;


@Data
public class FileUploadDto {
	private String UserId;
	private String PathName;
	private String ProjectId;
	private String FileId;
	private String FileName;
    private String FileNamePath;
    private String Rel;
    private String Ver;
	private InputStream IS;
	private String Description;
	private String SubL1;
	private String Docid;
	private String LabCode;
	
	
}
