package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filetracking")
public class PftsFileTracking {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int  FileTrackingId;
	private String  DemandNo;
	private String ForwardedBy;
	private String ForwardedTo;
	private int StatusId;
	private int EventId;
	private String Remarks;
	private int AckFlag;
	private String AckDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String EventDate;
	private String ActionDate;
	
	public int getFileTrackingId() {
		return FileTrackingId;
	}
	public void setFileTrackingId(int fileTrackingId) {
		FileTrackingId = fileTrackingId;
	}
	public String getDemandNo() {
		return DemandNo;
	}
	public void setDemandNo(String demandNo) {
		DemandNo = demandNo;
	}
	public String getForwardedBy() {
		return ForwardedBy;
	}
	public void setForwardedBy(String forwardedBy) {
		ForwardedBy = forwardedBy;
	}
	public String getForwardedTo() {
		return ForwardedTo;
	}
	public void setForwardedTo(String forwardedTo) {
		ForwardedTo = forwardedTo;
	}
	
	
	public int getStatusId() {
		return StatusId;
	}
	public void setStatusId(int statusId) {
		StatusId = statusId;
	}
	public int getEventId() {
		return EventId;
	}
	public void setEventId(int eventId) {
		EventId = eventId;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public int getAckFlag() {
		return AckFlag;
	}
	public void setAckFlag(int ackFlag) {
		AckFlag = ackFlag;
	}
	public String getAckDate() {
		return AckDate;
	}
	public void setAckDate(String ackDate) {
		AckDate = ackDate;
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
	public String getEventDate() {
		return EventDate;
	}
	public void setEventDate(String eventDate) {
		EventDate = eventDate;
	}
	public String getActionDate() {
		return ActionDate;
	}
	public void setActionDate(String actionDate) {
		ActionDate = actionDate;
	}
	
	
	
	
	
}                     
