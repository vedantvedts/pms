package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name="action_attachment")
public class ActionAttachment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionAttachId;
	private Long ActionSubId;
	private String AttachName;
	@Lob
	private byte[] ActionAttach;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
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
	public byte[] getActionAttach() {
		return ActionAttach;
	}
	public void setActionAttach(byte[] actionAttach) {
		ActionAttach = actionAttach;
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
