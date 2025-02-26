package com.vts.pfms.committee.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="action_sub")
public class ActionSub {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionSubId;
	private Long ActionAssignId;
	private int Progress;
	private Date ProgressDate;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	public Long getActionSubId() {
		return ActionSubId;
	}
	public void setActionSubId(Long actionSubId) {
		ActionSubId = actionSubId;
	}

	public Long getActionAssignId() {
		return ActionAssignId;
	}
	public void setActionAssignId(Long actionAssignId) {
		ActionAssignId = actionAssignId;
	}
	public int getProgress() {
		return Progress;
	}
	public void setProgress(int progress) {
		Progress = progress;
	}
	public Date getProgressDate() {
		return ProgressDate;
	}
	public void setProgressDate(Date progressDate) {
		ProgressDate = progressDate;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
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
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
}
