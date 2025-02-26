package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name="action_attachment")
public class ActionAttachment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionAttachId;
	private Long ActionSubId;
	private String AttachName;
	private String AttachFilePath;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	public String getAttachFilePath() {
		return AttachFilePath;
	}
	public void setAttachFilePath(String attachFilePath) {
		AttachFilePath = attachFilePath;
	}
	public Long getActionAttachId() {
		return ActionAttachId;
	}
	public void setActionAttachId(Long actionAttachId) {
		ActionAttachId = actionAttachId;
	}
	public Long getActionSubId() {
		return ActionSubId;
	}
	public void setActionSubId(Long actionSubId) {
		ActionSubId = actionSubId;
	}
	public String getAttachName() {
		return AttachName;
	}
	public void setAttachName(String attachName) {
		AttachName = attachName;
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
	
	
}
