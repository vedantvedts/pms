package com.vts.pfms.fracas.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_fracas_assign")
public class PfmsFracasAssign {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long FracasAssignId;
	private String FracasAssignNo;
	private long FracasMainId; 
	private String Remarks;
	private Date PDC;
	private long Assigner;
	private long Assignee;
	private String AssignedDate;
	private String FracasStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
	public long getFracasAssignId() {
		return FracasAssignId;
	}
	public long getFracasMainId() {
		return FracasMainId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public Date getPDC() {
		return PDC;
	}
	public long getAssigner() {
		return Assigner;
	}
	public long getAssignee() {
		return Assignee;
	}
	public String getAssignedDate() {
		return AssignedDate;
	}
	public String getFracasStatus() {
		return FracasStatus;
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
	public void setFracasAssignId(long fracasAssignId) {
		FracasAssignId = fracasAssignId;
	}
	public void setFracasMainId(long fracasMainId) {
		FracasMainId = fracasMainId;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public void setPDC(Date pDC) {
		PDC = pDC;
	}
	public void setAssigner(long assigner) {
		Assigner = assigner;
	}
	public void setAssignee(long assignee) {
		Assignee = assignee;
	}
	public void setAssignedDate(String assignedDate) {
		AssignedDate = assignedDate;
	}
	public void setFracasStatus(String fracasStatus) {
		FracasStatus = fracasStatus;
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
	public String getFracasAssignNo() {
		return FracasAssignNo;
	}
	public void setFracasAssignNo(String fracasAssignNo) {
		FracasAssignNo = fracasAssignNo;
	}
	
}
