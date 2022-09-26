package com.vts.pfms.project.dto;

public class ProjectScheduleDto {

	private String MileStoneActivity;
	private String MileStoneMonth;
	private String MileStoneRemark;

	public String getMileStoneRemark() {
		return MileStoneRemark;
	}

	public void setMileStoneRemark(String mileStoneRemark) {
		MileStoneRemark = mileStoneRemark;
	}

	private String InitiationScheduleId;
	private String UserId;
	private Integer TotalMonth;
	private String InitiationId;

	public String getMileStoneActivity() {
		return MileStoneActivity;
	}

	public void setMileStoneActivity(String mileStoneActivity) {
		MileStoneActivity = mileStoneActivity;
	}

	public String getMileStoneMonth() {
		return MileStoneMonth;
	}

	public void setMileStoneMonth(String mileStoneMonth) {
		MileStoneMonth = mileStoneMonth;
	}

	public String getInitiationScheduleId() {
		return InitiationScheduleId;
	}

	public void setInitiationScheduleId(String initiationScheduleId) {
		InitiationScheduleId = initiationScheduleId;
	}

	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public Integer getTotalMonth() {
		return TotalMonth;
	}

	public void setTotalMonth(Integer totalMonth) {
		TotalMonth = totalMonth;
	}

	public String getInitiationId() {
		return InitiationId;
	}

	public void setInitiationId(String initiationId) {
		InitiationId = initiationId;
	}
}
