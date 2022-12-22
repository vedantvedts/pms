package com.vts.pfms.project.dto;

import org.springframework.web.multipart.MultipartFile;

public class PfmsInitiationAuthorityFileDto {

	

	private String InitiationAuthorityFileId;
	private String AuthorityId;
	private String FilePath;
	private String AttachementName;
	private String OriginalName;
	private MultipartFile AttachFile;
	
	
	public MultipartFile getAttachFile() {
		return AttachFile;
	}
	public void setAttachFile(MultipartFile attachFile) {
		AttachFile = attachFile;
	}
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
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
	public void setInitiationAuthorityFileId(String initiationAuthorityFileId) {
		InitiationAuthorityFileId = initiationAuthorityFileId;
	}
	public void setAuthorityId(String authorityId) {
		AuthorityId = authorityId;
	}

	
    
	
}
