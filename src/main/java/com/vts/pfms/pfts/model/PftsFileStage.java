package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filestage")
public class PftsFileStage {
	
	
	@Id	
	private int FileStageNo;
	private String  FileStageId;
	private String FileStageName;
	public String getFileStageId() {
		return FileStageId;
	}
	public void setFileStageId(String fileStageId) {
		FileStageId = fileStageId;
	}
	public String getFileStageName() {
		return FileStageName;
	}
	public void setFileStageName(String fileStageName) {
		FileStageName = fileStageName;
	}
	public int getFileStageNo() {
		return FileStageNo;
	}
	public void setFileStageNo(int fileStageNo) {
		FileStageNo = fileStageNo;
	}
	
}
