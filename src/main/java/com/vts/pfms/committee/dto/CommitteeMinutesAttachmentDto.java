package com.vts.pfms.committee.dto;

import org.springframework.web.multipart.MultipartFile;

public class CommitteeMinutesAttachmentDto {
	private String MinutesAttachmentId;
	private String ScheduleAttachmentId;
	private String ScheduleId;
	private MultipartFile MinutesAttachment;
	private String AttachmentName;
	private String LabCode;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public String getScheduleAttachmentId() {
		return ScheduleAttachmentId;
	}
	public void setScheduleAttachmentId(String scheduleAttachmentId) {
		ScheduleAttachmentId = scheduleAttachmentId;
	}
	public String getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(String scheduleId) {
		ScheduleId = scheduleId;
	}
	
	public MultipartFile getMinutesAttachment() {
		return MinutesAttachment;
	}
	public void setMinutesAttachment(MultipartFile minutesAttachment) {
		MinutesAttachment = minutesAttachment;
	}
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
	}
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
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
	public String getMinutesAttachmentId() {
		return MinutesAttachmentId;
	}
	public void setMinutesAttachmentId(String minutesAttachmentId) {
		MinutesAttachmentId = minutesAttachmentId;
	}
	

}
