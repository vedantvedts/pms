package com.vts.pfms.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="lab_master")
public class LabMaster implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	private int LabMasterId;
	private String LabCode;
	private String LabName;
	private String LabUnitCode;
	private String LabAddress;
	private String LabCity;
	private String LabPin;
	private String LabTelNo;
	private String LabFaxNo;
	private String LabEmail;
	private String LabAuthority;
	private Long LabAuthorityId;
	private String LabRfpEmail;
	private Long LabId;
	private Long ClusterId;
	private byte[] LabLogo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	
	public String getLabAuthority() {
		return LabAuthority;
	}
	public void setLabAuthority(String labAuthority) {
		LabAuthority = labAuthority;
	}
	public Long getLabAuthorityId() {
		return LabAuthorityId;
	}
	public void setLabAuthorityId(Long labAuthorityId) {
		LabAuthorityId = labAuthorityId;
	}
	public String getLabRfpEmail() {
		return LabRfpEmail;
	}
	public void setLabRfpEmail(String labRfpEmail) {
		LabRfpEmail = labRfpEmail;
	}
	public Long getLabId() {
		return LabId;
	}
	public void setLabId(Long labId) {
		LabId = labId;
	}
	public Long getClusterId() {
		return ClusterId;
	}
	public void setClusterId(Long clusterId) {
		ClusterId = clusterId;
	}
	public byte[] getLabLogo() {
		return LabLogo;
	}
	public void setLabLogo(byte[] labLogo) {
		LabLogo = labLogo;
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
	public String getLabTelNo() {
		return LabTelNo;
	}
	public void setLabTelNo(String labTelNo) {
		LabTelNo = labTelNo;
	}
	public String getLabFaxNo() {
		return LabFaxNo;
	}
	public void setLabFaxNo(String labFaxNo) {
		LabFaxNo = labFaxNo;
	}
	public String getLabEmail() {
		return LabEmail;
	}
	public void setLabEmail(String labEmail) {
		LabEmail = labEmail;
	}
	public int getLabMasterId() {
		return LabMasterId;
	}
	public void setLabMasterId(int labMasterId) {
		LabMasterId = labMasterId;
	}
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public String getLabName() {
		return LabName;
	}
	public void setLabName(String labName) {
		LabName = labName;
	}
	public String getLabUnitCode() {
		return LabUnitCode;
	}
	public void setLabUnitCode(String labUnitCode) {
		LabUnitCode = labUnitCode;
	}
	public String getLabAddress() {
		return LabAddress;
	}
	public void setLabAddress(String labAddress) {
		LabAddress = labAddress;
	}
	public String getLabCity() {
		return LabCity;
	}
	public void setLabCity(String labCity) {
		LabCity = labCity;
	}
	public String getLabPin() {
		return LabPin;
	}
	public void setLabPin(String labPin) {
		LabPin = labPin;
	}
	
	
	
}
