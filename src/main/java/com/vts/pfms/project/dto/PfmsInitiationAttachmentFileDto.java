package com.vts.pfms.project.dto;

public class PfmsInitiationAttachmentFileDto {

	

	private String InitiationAttachmentFileId;
	private String InitiationAttachmentId;
    private byte[] FilePath;
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
	public byte[] getFilePath() {
		return FilePath;
	}
	public void setFilePath(byte[] filePath) {
		FilePath = filePath;
	}

    
	
}
