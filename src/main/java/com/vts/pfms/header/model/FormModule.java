package com.vts.pfms.header.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
@Entity
@Table(name="form_module")
public class FormModule implements Serializable {
	

	private static final long serialVersionUID = 1L;
	@Id
	private Long FormModuleId ;
	private String FormModuleName ;
	private String ModuleUrl ;
	private String ModuleIcon ;
	private Long SerialNo ;
	private int IsActive ;
	public Long getFormModuleId() {
		return FormModuleId;
	}
	public void setFormModuleId(Long formModuleId) {
		FormModuleId = formModuleId;
	}
	public String getFormModuleName() {
		return FormModuleName;
	}
	public void setFormModuleName(String formModuleName) {
		FormModuleName = formModuleName;
	}
	public Long getSerialNo() {
		return SerialNo;
	}
	public void setSerialNo(Long serialNo) {
		SerialNo = serialNo;
	}
	
	public String getModuleUrl() {
		return ModuleUrl;
	}
	public void setModuleUrl(String moduleUrl) {
		ModuleUrl = moduleUrl;
	}
	public String getModuleIcon() {
		return ModuleIcon;
	}
	public void setModuleIcon(String moduleIcon) {
		ModuleIcon = moduleIcon;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
	
	
}
