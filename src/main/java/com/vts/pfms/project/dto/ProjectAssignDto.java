package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class ProjectAssignDto {

	private long ProjectEmployeeId;
	private String[] EmpId;
	private String ProjectId;
	private String RoleMasterId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
