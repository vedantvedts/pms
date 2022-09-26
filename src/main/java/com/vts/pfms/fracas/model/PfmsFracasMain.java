package com.vts.pfms.fracas.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name = "pfms_fracas_main")
public class  PfmsFracasMain  {
		
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FracasMainId;
	private int FracasTypeId;
	private String FracasItem;
	private String FracasDate;
	private long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
	public long getFracasMainId() {
		return FracasMainId;
	}
	public int getFracasTypeId() {
		return FracasTypeId;
	}
	public String getFracasItem() {
		return FracasItem;
	}
	public String getFracasDate() {
		return FracasDate;
	}
	public long getProjectId() {
		return ProjectId;
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
	public void setFracasMainId(long fracasMainId) {
		FracasMainId = fracasMainId;
	}
	public void setFracasTypeId(int fracasTypeId) {
		FracasTypeId = fracasTypeId;
	}
	public void setFracasItem(String fracasItem) {
		FracasItem = fracasItem;
	}
	public void setFracasDate(String fracasDate) {
		FracasDate = fracasDate;
	}
	public void setProjectId(long projectId) {
		ProjectId = projectId;
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
	
}
