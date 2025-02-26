package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_initiation_attachment_file")
public class PfmsInitiationAttachmentFile implements Serializable {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationAttachmentFileId;
	private Long InitiationAttachmentId;
    private String FilePath;
    private String FileName;
  
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public Long getInitiationAttachmentFileId() {
		return InitiationAttachmentFileId;
	}
	public void setInitiationAttachmentFileId(Long initiationAttachmentFileId) {
		InitiationAttachmentFileId = initiationAttachmentFileId;
	}
	public Long getInitiationAttachmentId() {
		return InitiationAttachmentId;
	}
	public void setInitiationAttachmentId(Long initiationAttachmentId) {
		InitiationAttachmentId = initiationAttachmentId;
	}
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
   
    
	
}
