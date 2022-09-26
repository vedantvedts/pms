package com.vts.pfms.project.dto;

public class PfmsInitiationAuthorityDto {

	private String AuthorityId;
	private String InitiationId;
	private String AuthorityName;
	private String LetterDate;
	private String LetterNo;

	private String FileNamePath;
	public String getAuthorityId() {
		return AuthorityId;
	}
	public String getInitiationId() {
		return InitiationId;
	}
	public String getAuthorityName() {
		return AuthorityName;
	}
	public String getLetterDate() {
		return LetterDate;
	}
	public String getLetterNo() {
		return LetterNo;
	}

	public String getFileNamePath() {
		return FileNamePath;
	}
	public void setAuthorityId(String authorityId) {
		AuthorityId = authorityId;
	}
	public void setInitiationId(String initiationId) {
		InitiationId = initiationId;
	}
	public void setAuthorityName(String authorityName) {
		AuthorityName = authorityName;
	}
	public void setLetterDate(String letterDate) {
		LetterDate = letterDate;
	}
	public void setLetterNo(String letterNo) {
		LetterNo = letterNo;
	}
	
	public void setFileNamePath(String fileNamePath) {
		FileNamePath = fileNamePath;
	}
	
	
}
