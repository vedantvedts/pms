package com.vts.pfms.milestone.dto;

public class MileEditDto {
	private String MilestoneActivityId;
	private String ActivityId;
	private String ProjectId;
	private String ActivityType;
	private String ActivityTypeId;
	private String MilestoneNo;
	private String ActivityName;
	private String StartDate;
	private String EndDate;
	private String OicEmpId;
	private String OicEmpId1;
	private String ProgressStatus;
	private String ActivityStatusId;
	private String StatusRemarks;
	private String DateOfCompletion;
	private String RevisionNo;
	private String Weightage;
	private String FileName;
    private String FileNamePath;
	private byte[] FilePath;
	private String CreatedBy;
	private String CreatedDate;
	public String getProgressStatus() {
		return ProgressStatus;
	}
	public void setProgressStatus(String progressStatus) {
		ProgressStatus = progressStatus;
	}
	
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getActivityStatusId() {
		return ActivityStatusId;
	}
	public void setActivityStatusId(String activityStatusId) {
		ActivityStatusId = activityStatusId;
	}
	public String getStatusRemarks() {
		return StatusRemarks;
	}
	public void setStatusRemarks(String statusRemarks) {
		StatusRemarks = statusRemarks;
	}
	public String getDateOfCompletion() {
		return DateOfCompletion;
	}
	public void setDateOfCompletion(String dateOfCompletion) {
		DateOfCompletion = dateOfCompletion;
	}
	
	public String getMilestoneActivityId() {
		return MilestoneActivityId;
	}
	public void setMilestoneActivityId(String milestoneActivityId) {
		MilestoneActivityId = milestoneActivityId;
	}
	public String getActivityId() {
		return ActivityId;
	}
	public void setActivityId(String activityId) {
		ActivityId = activityId;
	}
	public String getActivityType() {
		return ActivityType;
	}
	public void setActivityType(String activityType) {
		ActivityType = activityType;
	}
	
	public String getActivityTypeId() {
		return ActivityTypeId;
	}
	public void setActivityTypeId(String activityTypeId) {
		ActivityTypeId = activityTypeId;
	}
	public String getMilestoneNo() {
		return MilestoneNo;
	}
	public void setMilestoneNo(String milestoneNo) {
		MilestoneNo = milestoneNo;
	}
	public String getActivityName() {
		return ActivityName;
	}
	public void setActivityName(String activityName) {
		ActivityName = activityName;
	}
	public String getStartDate() {
		return StartDate;
	}
	public void setStartDate(String startDate) {
		StartDate = startDate;
	}
	public String getEndDate() {
		return EndDate;
	}
	public void setEndDate(String endDate) {
		EndDate = endDate;
	}
	public String getOicEmpId() {
		return OicEmpId;
	}
	public void setOicEmpId(String oicEmpId) {
		OicEmpId = oicEmpId;
	}
	public String getOicEmpId1() {
		return OicEmpId1;
	}
	public void setOicEmpId1(String oicEmpId1) {
		OicEmpId1 = oicEmpId1;
	}
	public String getRevisionNo() {
		return RevisionNo;
	}
	public void setRevisionNo(String revisionNo) {
		RevisionNo = revisionNo;
	}
	/**
	 * @return the weightage
	 */
	public String getWeightage() {
		return Weightage;
	}
	/**
	 * @param weightage the weightage to set
	 */
	public void setWeightage(String weightage) {
		Weightage = weightage;
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
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getFileNamePath() {
		return FileNamePath;
	}
	public void setFileNamePath(String fileNamePath) {
		FileNamePath = fileNamePath;
	}
	public byte[] getFilePath() {
		return FilePath;
	}
	public void setFilePath(byte[] filePath) {
		FilePath = filePath;
	}
	
    
}
