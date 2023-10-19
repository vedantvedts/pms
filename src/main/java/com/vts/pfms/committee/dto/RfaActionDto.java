package com.vts.pfms.committee.dto;

import java.util.Date;

import lombok.Data;

@Data
public class RfaActionDto 
{
	private Long RfaId;
	private String LabCode;
	private Long ProjectId;
	private Long RfaNo;
	private Date RfaDate;
	private Long PriorityId;
	private Long CategoryId;
	private String Statement;
	private String Description;
	private String Reference;
	private Long AssigneeId;
	private String AssignorId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
