package com.vts.pfms.project.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfms_initiation_authority")
public class PfmsInitiationAuthority {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AuthorityId;
	private Long InitiationId;
	private Long AuthorityName;
	private Date LetterDate;
	private String LetterNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	public Long getAuthorityId() {
		return AuthorityId;
	}
	public Long getInitiationId() {
		return InitiationId;
	}
	
	
	public String getLetterNo() {
		return LetterNo;
	}

	public String getCreatedBy() {
		return CreatedBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setAuthorityId(Long authorityId) {
		AuthorityId = authorityId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	
	
	
	
	
	public Long getAuthorityName() {
		return AuthorityName;
	}
	public void setAuthorityName(Long authorityName) {
		AuthorityName = authorityName;
	}
	public Date getLetterDate() {
		return LetterDate;
	}
	public void setLetterDate(Date letterDate) {
		LetterDate = letterDate;
	}
	public void setLetterNo(String letterNo) {
		LetterNo = letterNo;
	}

	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	
}
