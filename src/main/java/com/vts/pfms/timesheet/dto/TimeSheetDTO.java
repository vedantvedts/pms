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
	private String[] ProjectId;
	private String[] ProjectIdhidden;
	private String[] ActivityType;
	private String[] ActivityTypeId;
	private String[] ActivityFromTime;
	private String[] ActivityToTime;
	private String[] ActivityDuration;
	private String[] Remarks;
	// New Columns for Sample Demo
	private String[] ActivityTypeDesc;
	private String[] AssignedByandPDC;
	private String[] WorkDone;
	
	private String UserId;
	private String Action;
}
