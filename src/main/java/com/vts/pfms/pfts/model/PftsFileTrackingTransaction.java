package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filetrackingtransaction")
public class PftsFileTrackingTransaction {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int  FileTrackingTransactionId;
	private int  FileTrackingId;
	private String ForwardedBy;
	private String ForwardedTo;

	private int EventId;
	private int AckFlag;
	private String ReceiveForwardedDate;
	private String ReturnForwardedDate;
	private String ReturnRemarks;
	private String ReturnDate;
	
	private String AckDate;
    private String Remarks;
    private String ActionBy;
    private String ActionDate;
    private int    EventCreatorId;
    private String EventDate;    
    
    public int getFileTrackingTransactionId() {
		return FileTrackingTransactionId;
	}
	public void setFileTrackingTransactionId(int fileTrackingTransactionId) {
		FileTrackingTransactionId = fileTrackingTransactionId;
	}
	public int getFileTrackingId() {
		return FileTrackingId;
	}
	public void setFileTrackingId(int fileTrackingId) {
		FileTrackingId = fileTrackingId;
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
	
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
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
	
	
	public int getEventId() {
		return EventId;
	}
	public void setEventId(int eventId) {
		EventId = eventId;
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
	public String getReceiveForwardedDate() {
		return ReceiveForwardedDate;
	}
	public void setReceiveForwardedDate(String receiveForwardedDate) {
		ReceiveForwardedDate = receiveForwardedDate;
	}
	public String getReturnForwardedDate() {
		return ReturnForwardedDate;
	}
	public void setReturnForwardedDate(String returnForwardedDate) {
		ReturnForwardedDate = returnForwardedDate;
	}
	public String getReturnRemarks() {
		return ReturnRemarks;
	}
	public void setReturnRemarks(String returnRemarks) {
		ReturnRemarks = returnRemarks;
	}
	public String getReturnDate() {
		return ReturnDate;
	}
	public void setReturnDate(String returnDate) {
		ReturnDate = returnDate;
	}
	public int getEventCreatorId() {
		return EventCreatorId;
	}
	public void setEventCreatorId(int eventCreatorId) {
		EventCreatorId = eventCreatorId;
	}
	public String getEventDate() {
		return EventDate;
	}
	public void setEventDate(String eventDate) {
		EventDate = eventDate;
	}
	
    
    
    
    
    
}
