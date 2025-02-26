package com.vts.pfms.fracas.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_fracas_sub")
public class PfmsFracasSub {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FracasSubId;
	private long FracasAssignId;
	private int Progress;
	private String Remarks;
	private String ProgressDate;
	private String CreatedBy;
	private String CreatedDate;
	
	
	public long getFracasSubId() {
		return FracasSubId;
	}
	public long getFracasAssignId() {
		return FracasAssignId;
	}
	public int getProgress() {
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
	public void setFracasSubId(long fracasSubId) {
		FracasSubId = fracasSubId;
	}
	public void setFracasAssignId(long fracasAssignId) {
		FracasAssignId = fracasAssignId;
	}
	public void setProgress(int progress) {
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
	
	
	
}
