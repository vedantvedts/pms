package com.vts.pfms.requirements.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="pfms_testsetup_attachements")
@Data
public class TestSetUpAttachment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="AttachmentId")
	private Long attachmentId;
	@Column(name="setupId")
	private Long setupId;
	
	@Column(name="LabCode")
	private String labCode;
	
	@Column(name="AttachmentFileName")
	private String attachmentFileName;
	
	@Column(name="FilePath")
	private String filePath;
	
	@Column(name="IsActive")
	private Integer isActive;
}
