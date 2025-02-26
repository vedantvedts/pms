package com.vts.pfms.fracas.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name="pfms_fracas_attach")
public class PfmsFracasAttach {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FracasAttachId;
	private long FracasMainId;
	private long FracasSubId;
	private String AttachName;
	private String FilePath;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	public long getFracasAttachId() {
		return FracasAttachId;
	}
	public long getFracasMainId() {
		return FracasMainId;
	}
	public long getFracasSubId() {
		return FracasSubId;
	}
	public String getAttachName() {
		return AttachName;
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
	public void setFracasAttachId(long fracasAttachId) {
		FracasAttachId = fracasAttachId;
	}
	public void setFracasMainId(long fracasMainId) {
		FracasMainId = fracasMainId;
	}
	public void setFracasSubId(long fracasSubId) {
		FracasSubId = fracasSubId;
	}
	public void setAttachName(String attachName) {
		AttachName = attachName;
	}
	
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
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
