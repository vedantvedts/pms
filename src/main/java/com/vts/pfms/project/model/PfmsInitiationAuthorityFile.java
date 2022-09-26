package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "pfms_initiation_authority_file")
public class PfmsInitiationAuthorityFile {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationAuthorityFileId;
	private Long AuthorityId;
	@Lob
	private byte[] File;
	private String AttachmentName;
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
	public byte[] getFile() {
		return File;
	}
	public void setInitiationAuthorityFileId(Long initiationAuthorityFileId) {
		InitiationAuthorityFileId = initiationAuthorityFileId;
	}
	public void setAuthorityId(Long authorityId) {
		AuthorityId = authorityId;
	}
	public void setFile(byte[] file) {
		File = file;
	}
	
	
}
