package com.vts.pfms.fracas.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name="pfms_fracas_attach")
public class PfmsFracasAttach {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FracasAttachId;
	private long FracasMainId;
	private long FracasSubId;
	private String AttachName;
	@Lob
	private byte[] FracasAttach;
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
	public byte[] getFracasAttach() {
		return FracasAttach;
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
	public void setFracasAttach(byte[] fracasAttach) {
		FracasAttach = fracasAttach;
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
