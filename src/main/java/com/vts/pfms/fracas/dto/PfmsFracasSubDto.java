package com.vts.pfms.fracas.dto;

import org.springframework.web.multipart.MultipartFile;

public class PfmsFracasSubDto {

	
	private String FracasSubId;
	private String FracasAssignId;
	private String Progress;
	private String Remarks;
	private String ProgressDate;
	private String CreatedBy;
	private String CreatedDate;
	private MultipartFile attachment;
	private String LabCode;
	
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public String getFracasSubId() {
		return FracasSubId;
	}
	public String getFracasAssignId() {
		return FracasAssignId;
	}
	public String getProgress() {
		return Progress;
	}
	public String getRemarks() {
		return Remarks;
	}
	public String getProgressDate() {
		return ProgressDate;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public MultipartFile getAttachment() {
		return attachment;
	}
	public void setFracasSubId(String fracasSubId) {
		FracasSubId = fracasSubId;
	}
	public void setFracasAssignId(String fracasAssignId) {
		FracasAssignId = fracasAssignId;
	}
	public void setProgress(String progress) {
		Progress = progress;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public void setProgressDate(String progressDate) {
		ProgressDate = progressDate;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setAttachment(MultipartFile attachment) {
		this.attachment = attachment;
	}
	
	
}
