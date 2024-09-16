package com.vts.pfms.admin.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
/* @Table(name = "pfms_rtmddo") */
 @Table(name="pfms_initiation_approver") 
public class PfmsRtmddo  implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RtmddoId;
	private Long EmpId;
	private Date ValidFrom;
	private Date ValidTo;
	private String Type;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String LabCode;
	private Long InitiationId; 
	public Long getInitiationId() { 
		return InitiationId; 
		} 
	public void setInitiationId(Long initiationId) { 
		InitiationId= initiationId; 
		}
	
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public Long getRtmddoId() {
		return RtmddoId;
	}
	public void setRtmddoId(Long rtmddoId) {
		RtmddoId = rtmddoId;
	}
	public Long getEmpId() {
		return EmpId;
	}
	public void setEmpId(Long empId) {
		EmpId = empId;
	}
	public Date getValidFrom() {
		return ValidFrom;
	}
	public void setValidFrom(Date validFrom) {
		ValidFrom = validFrom;
	}
	public Date getValidTo() {
		return ValidTo;
	}
	public void setValidTo(Date validTo) {
		ValidTo = validTo;
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
	/**
	 * @return the type
	 */
	public String getType() {
		return Type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		Type = type;
	}
	
	
}
