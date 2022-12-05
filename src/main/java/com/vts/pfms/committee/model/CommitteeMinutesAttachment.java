package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="committee_minutes_attachment")
public class CommitteeMinutesAttachment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long MinutesAttachmentId;
	private long ScheduleId;
	private String FilePath;
	private String AttachmentName;
	private String CreatedDate;
	private String CreatedBy;
	private String ModifiedBy;
	private String ModifiedDate;
	public long getMinutesAttachmentId() {
		return MinutesAttachmentId;
	}
	public void setMinutesAttachmentId(long minutesAttachmentId) {
		MinutesAttachmentId = minutesAttachmentId;
	}
	public long getScheduleId() {
		return ScheduleId;
	}
	public void setScheduleId(long scheduleId) {
		ScheduleId = scheduleId;
	}
	
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
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
	
	
}
