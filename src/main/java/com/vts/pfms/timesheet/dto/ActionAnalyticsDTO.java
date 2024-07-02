package com.vts.pfms.timesheet.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActionAnalyticsDTO {

	private Long ActionMainId;
	private String EmpName;
	private String Designation;
	private String ActionDate;
	private String EndDate;
	private String ActionItem;
	private String ActionStatus;
	private String ActionNo;
	private Long ActionAssignId;
	private Long Assignee;
	private Long Assignor;
	private Long ActionLevel;
	private Long ProjectId;
	private String ClosedDate;
	
}
