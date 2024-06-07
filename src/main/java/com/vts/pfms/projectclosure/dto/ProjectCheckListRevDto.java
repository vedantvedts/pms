package com.vts.pfms.projectclosure.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProjectCheckListRevDto {
	
	private long ClosureId;
	private String[] RevisionType;
	private String[] RequestedDate;
	private String[] GrantedDate;
	private String[] RevisionCost;
	private String[] RevisionPDC;
	private String[] Reason;
	

}
