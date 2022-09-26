package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_fileevents")
public class PftsFileEvents {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int    FileEventId;
	private String EventNumber;
	private String FileStageId;
    private String EventName;
	private String FtUserType;
	private String MilestoneFlag;
	
	public int getFileEventId() {
		return FileEventId;
	}
	public void setFileEventId(int fileEventId) {
		FileEventId = fileEventId;
	}
	public String getEventNumber() {
		return EventNumber;
	}
	public void setEventNumber(String eventNumber) {
		EventNumber = eventNumber;
	}
	
	
	
	public String getEventName() {
		return EventName;
	}
	public void setEventName(String eventName) {
		EventName = eventName;
	}
	public String getFileStageId() {
		return FileStageId;
	}
	public void setFileStageId(String fileStageId) {
		FileStageId = fileStageId;
	}
	public String getFtUserType() {
		return FtUserType;
	}
	public void setFtUserType(String ftUserType) {
		FtUserType = ftUserType;
	}
	public String getMilestoneFlag() {
		return MilestoneFlag;
	}
	public void setMilestoneFlag(String milestoneFlag) {
		MilestoneFlag = milestoneFlag;
	}
	
	
	
	
}
