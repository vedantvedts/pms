package com.vts.pfms.admin.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="division_master")
public class DivisionMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DivisionId;
	private String LabCode;
	private String DivisionCode;
	private String DivisionName;
	private long DivisionHeadId;
	private long GroupId;
	private Integer IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public void setIsActive(Integer isActive) {
		IsActive = isActive;
	}
	public Long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(Long divisionId) {
		DivisionId = divisionId;
	}
	public String getDivisionCode() {
		return DivisionCode;
	}
	public void setDivisionCode(String divisionCode) {
		DivisionCode = divisionCode;
	}
	public String getDivisionName() {
		return DivisionName;
	}
	public void setDivisionName(String divisionName) {
		DivisionName = divisionName;
	}
	public long getDivisionHeadId() {
		return DivisionHeadId;
	}
	public void setDivisionHeadId(long l) {
		DivisionHeadId = l;
	}
	public long getGroupId() {
		return GroupId;
	}
	public void setGroupId(long l) {
		GroupId = l;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
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
	public void setCreatedDate(String string) {
		CreatedDate = string;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String string) {
		ModifiedDate = string;
	}
	 
	
}
