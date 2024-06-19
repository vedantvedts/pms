package com.vts.pfms.timesheet.dto;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class TimeSheetDTO {

	private String TimeSheetId;
	private String EmpId;
	private String InitiationDate;
	private String ActivityFromDate;
	private String ActivityToDate;
	private String PunchInTime;
	private String PunchOutTime;
	private String EmpStatus;
	private String TDRemarks;
	private String TimeSheetStatus;
	private String TotalDuration;
	
	private String[] ActivityId;
	private String[] ActivityType;
	private String[] ActivityName;
	private String[] ActivityFromTime;
	private String[] ActivityToTime;
	private String[] ActivityDuration;
	private String[] Remarks;
	
	private String UserId;
	private String Action;
}
