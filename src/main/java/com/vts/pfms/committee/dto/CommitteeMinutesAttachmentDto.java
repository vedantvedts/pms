package com.vts.pfms.committee.dto;

public class CommitteeMinutesAttachmentDto {
	private String MinutesAttachmentId;
	private String ScheduleAttachmentId;
	private String ScheduleId;
	private byte[] MinutesAttachment;
	private String AttachmentName;
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
	public byte[] getMinutesAttachment() {
		return MinutesAttachment;
	}
	public void setMinutesAttachment(byte[] minutesAttachment) {
		MinutesAttachment = minutesAttachment;
	}
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
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
