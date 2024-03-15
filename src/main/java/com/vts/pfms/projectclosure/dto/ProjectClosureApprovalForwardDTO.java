package com.vts.pfms.projectclosure.dto;

import lombok.Data;

@Data
public class ProjectClosureApprovalForwardDTO {

//	private long closureSoCId;
	private String projectId;
	private String closureId;
	private String action;
	private String EmpId;
	private String UserId;
	private String remarks;
	private String labcode;
	private String approverLabCode;
	private String approverEmpId;
	private String approvalDate;
}
