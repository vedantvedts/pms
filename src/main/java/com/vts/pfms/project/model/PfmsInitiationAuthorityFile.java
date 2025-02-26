package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_initiation_authority_file")
public class PfmsInitiationAuthorityFile {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationAuthorityFileId;
	private Long AuthorityId;
	private String File;
	private String AttachmentName;
	
	public String getFile() {
		return File;
	}
	public void setFile(String file) {
		File = file;
	}
	public String getAttachmentName() {
		return AttachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		AttachmentName = attachmentName;
	}
	public Long getInitiationAuthorityFileId() {
		return InitiationAuthorityFileId;
	}
	public Long getAuthorityId() {
		return AuthorityId;
	}
	public void setInitiationAuthorityFileId(Long initiationAuthorityFileId) {
		InitiationAuthorityFileId = initiationAuthorityFileId;
	}
	public void setAuthorityId(Long authorityId) {
		AuthorityId = authorityId;
	}

	
	
}
