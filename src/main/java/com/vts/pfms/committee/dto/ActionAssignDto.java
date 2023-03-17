package com.vts.pfms.committee.dto;

import lombok.Data;

@Data
public class ActionAssignDto {

	private Long ActionAssignId;
	private Long ActionMainId;
	private String ActionNo;
	private String ActionDate;
	private String ActionType;
	private String ScheduleId;
	private String ProjectId;
	private String EndDate;
	private String PDCOrg;
	private String PDC1;
	private String PDC2;
	private int Revision;
	private String AssignorLabCode;
	private Long Assignor;
	private String AssigneeLabCode;
	private Long Assignee;
	private String Remarks;
	private String ActionStatus;
//	private String ActionFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsSeen;
	private int IsActive;
	private String [] AssigneeList;
	private String MeetingDate;
	
	
}
