package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filecurrentstatus")
public class PftsFileCurrentStatus {

	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int  FileCurrentStatusId;
	private String CurrentStatus;
	
	
	
	
	public int getFileCurrentStatusId() {
		return FileCurrentStatusId;
	}
	public void setFileCurrentStatusId(int fileCurrentStatusId) {
		FileCurrentStatusId = fileCurrentStatusId;
	}
	public String getCurrentStatus() {
		return CurrentStatus;
	}
	public void setCurrentStatus(String currentStatus) {
		CurrentStatus = currentStatus;
	}
	
	
}
