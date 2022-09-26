package com.vts.pfms.project.dto;

public class PfmsInitiationAuthorityFileDto {

	

	private String InitiationAuthorityFileId;
	private String AuthorityId;
	private byte[] FilePath;
	private String AttachementName;
	private String OriginalName;
	
	public String getOriginalName() {
		return OriginalName;
	}
	public void setOriginalName(String originalName) {
		OriginalName = originalName;
	}
	public String getAttachementName() {
		return AttachementName;
	}
	public void setAttachementName(String attachementName) {
		AttachementName = attachementName;
	}
	public String getInitiationAuthorityFileId() {
		return InitiationAuthorityFileId;
	}
	public String getAuthorityId() {
		return AuthorityId;
	}
	public byte[] getFilePath() {
		return FilePath;
	}
	public void setInitiationAuthorityFileId(String initiationAuthorityFileId) {
		InitiationAuthorityFileId = initiationAuthorityFileId;
	}
	public void setAuthorityId(String authorityId) {
		AuthorityId = authorityId;
	}
	public void setFilePath(byte[] filePath) {
		FilePath = filePath;
	}
	
    
	
}
