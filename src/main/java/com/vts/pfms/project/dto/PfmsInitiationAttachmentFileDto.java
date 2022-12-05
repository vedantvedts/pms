package com.vts.pfms.project.dto;

import org.springframework.web.multipart.MultipartFile;

public class PfmsInitiationAttachmentFileDto {

	

	private String InitiationAttachmentFileId;
	private String InitiationAttachmentId;
    private MultipartFile FileAttach;
    private String LabCode;
	public String getInitiationAttachmentFileId() {
		return InitiationAttachmentFileId;
	}
	public void setInitiationAttachmentFileId(String initiationAttachmentFileId) {
		InitiationAttachmentFileId = initiationAttachmentFileId;
	}
	public String getInitiationAttachmentId() {
		return InitiationAttachmentId;
	}
	public void setInitiationAttachmentId(String initiationAttachmentId) {
		InitiationAttachmentId = initiationAttachmentId;
	}
	public MultipartFile getFileAttach() {
		return FileAttach;
	}
	public void setFileAttach(MultipartFile fileAttach) {
		FileAttach = fileAttach;
	}
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	

    
	
}
