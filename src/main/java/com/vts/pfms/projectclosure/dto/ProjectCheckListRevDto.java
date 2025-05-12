package com.vts.pfms.projectclosure.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProjectCheckListRevDto {
	
	private long ClosureId;
	private String[] RevisionType;
	private String[] SCRequestedDate;
	private String[] SCGrantedDate;
	private String[] SCRevisionCost;
	private String[] SCReason;
	private String[] PDCRequestedDate;
	private String[] PDCGrantedDate;
	private String[] PDCRevised;
	private String[] PDCReason;
	private String RevSancCost;
	private String RevPDCCost;

}
