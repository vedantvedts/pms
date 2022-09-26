package com.vts.pfms.milestone.dto;

import java.io.InputStream;

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
	
	
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getFileRepUploadId() {
		return FileRepUploadId;
	}
	public void setFileRepUploadId(String fileRepUploadId) {
		FileRepUploadId = fileRepUploadId;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	
	public String getAmendVersion() {
		return AmendVersion;
	}
	public void setAmendVersion(String amendVersion) {
		AmendVersion = amendVersion;
	}
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	public String getFilePass() {
		return FilePass;
	}
	public void setFilePass(String filePass) {
		FilePass = filePass;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public InputStream getInStream() {
		return InStream;
	}
	public void setInStream(InputStream inStream) {
		InStream = inStream;
	}
	
	
}
