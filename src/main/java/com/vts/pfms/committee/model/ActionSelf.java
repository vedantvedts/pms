package com.vts.pfms.committee.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_action_self")
public class ActionSelf {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionId;
	private Long EmpId;
	private String ActionItem;
	private Date ActionDate;
	private String ActionTime;
	private String ActionType;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	private String LabCode;
	
	public String getLabCode() {
		return LabCode;
	}

	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	
	public Long getActionId() {
		return ActionId;
	}
	
	public void setActionId(Long actionId) {
		ActionId = actionId;
	}
	
	public Long getEmpId() {
		return EmpId;
	}
	
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	
	public String getActionItem() {
		return ActionItem;
	}
	
	public void setActionItem(String actionItem) {
		ActionItem = actionItem;
	}
	
	public Date getActionDate() {
		return ActionDate;
	}
	
	public void setActionDate(Date actionDate) {
		ActionDate = actionDate;
	}
	
	public String getActionTime() {
		return ActionTime;
	}
	
	public void setActionTime(String actionTime) {
		ActionTime = actionTime;
	}
	
	public String getActionType() {
		return ActionType;
	}
	
	public void setActionType(String actionType) {
		ActionType = actionType;
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
	
	public int getIsActive() {
		return IsActive;
	}
	
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
		
	
}
