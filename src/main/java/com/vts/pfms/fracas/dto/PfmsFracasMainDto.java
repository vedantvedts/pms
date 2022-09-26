package com.vts.pfms.fracas.dto;

import org.springframework.web.multipart.MultipartFile;

public class PfmsFracasMainDto {
	private String  FracasMainId;
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
	
	
	public String getFracasMainId() {
		return FracasMainId;
	}
	public String getFracasNo() {
		return FracasNo;
	}
	public String getFracasTypeId() {
		return FracasTypeId;
	}
	public String getFracasItem() {
		return FracasItem;
	}
	public String getFracasDate() {
		return FracasDate;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public String getFracasFlag() {
		return FracasFlag;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setFracasMainId(String fracasMainId) {
		FracasMainId = fracasMainId;
	}
	public void setFracasNo(String fracasNo) {
		FracasNo = fracasNo;
	}
	public void setFracasTypeId(String fracasTypeId) {
		FracasTypeId = fracasTypeId;
	}
	public void setFracasItem(String fracasItem) {
		FracasItem = fracasItem;
	}
	public void setFracasDate(String fracasDate) {
		FracasDate = fracasDate;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public void setFracasFlag(String fracasFlag) {
		FracasFlag = fracasFlag;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public MultipartFile getFracasMainAttach() {
		return FracasMainAttach;
	}
	public void setFracasMainAttach(MultipartFile fracasMainAttach) {
		FracasMainAttach = fracasMainAttach;
	}
	public String getFracasMainAttachId() {
		return FracasMainAttachId;
	}
	public void setFracasMainAttachId(String fracasMainAttachId) {
		FracasMainAttachId = fracasMainAttachId;
	}
	
	
}
