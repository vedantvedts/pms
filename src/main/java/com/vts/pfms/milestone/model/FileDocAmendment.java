package com.vts.pfms.milestone.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "file_doc_amendment")
public class FileDocAmendment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long DocAmendmentId;
	private long FileRepUploadId;
	private String FileName;
	private String AmendmentName;
	private String Description;
	private int AmendVersion;
	private String FilePath;
	private String FilePass;
	private String CreatedBy;
	private String CreatedDate;
	public long getDocAmendmentId() {
		return DocAmendmentId;
	}
	public void setDocAmendmentId(long docAmendmentId) {
		DocAmendmentId = docAmendmentId;
	}
	public long getFileRepUploadId() {
		return FileRepUploadId;
	}
	public void setFileRepUploadId(long fileRepUploadId) {
		FileRepUploadId = fileRepUploadId;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getAmendmentName() {
		return AmendmentName;
	}
	public void setAmendmentName(String amendmentName) {
		AmendmentName = amendmentName;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public int getAmendVersion() {
		return AmendVersion;
	}
	public void setAmendVersion(int amendVersion) {
		AmendVersion = amendVersion;
	}
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	public String getFilePass() {
		return FilePass;
	}
	public void setFilePass(String filePass) {
		FilePass = filePass;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	
	
}
