package com.vts.pfms.committee.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_main")
public class CommitteeMain implements Serializable {
	
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CommitteeMainId;
	private long CommitteeId;
	private Date ValidFrom;
	private Date ValidTo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String PreApproved;
	private int IsActive;
	private long ProjectId;
	private long DivisionId;
	private long InitiationId;
	private String Status;
	
	
	public long getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(long committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public long getCommitteeId() {
		return CommitteeId;
	}
	public void setCommitteeId(long committeeId) {
		CommitteeId = committeeId;
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
	public long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(long projectId) {
		ProjectId = projectId;
	}
	public long getDivisionId() {
		return DivisionId;
	}
	public void setDivisionId(long divisionId) {
		DivisionId = divisionId;
	}
	public long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(long initiationId) {
		InitiationId = initiationId;
	}
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}
	public String getPreApproved() {
		return PreApproved;
	}
	public void setPreApproved(String preApproved) {
		PreApproved = preApproved;
	}
	
}
