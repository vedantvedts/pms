package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "project_approval")
public class PfmsApproval implements Serializable {


	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ProjectApprovalId;
	private Long InitiationId;
    private Long EmpId;
    private String Remarks;

    private String ProjectStatus;
    private String ActionBy;
    private String ActionDate;
	public Long getProjectApprovalId() {
		return ProjectApprovalId;
	}
	public void setProjectApprovalId(Long projectApprovalId) {
		ProjectApprovalId = projectApprovalId;
	}


	public Long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public String getProjectStatus() {
		return ProjectStatus;
	}
	public void setProjectStatus(String projectStatus) {
		ProjectStatus = projectStatus;
	}
	public String getActionBy() {
		return ActionBy;
	}
	public void setActionBy(String actionBy) {
		ActionBy = actionBy;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
   
	
	
    
	
}
