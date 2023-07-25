package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class ProjectOtherReqDto {

	private Long RequirementId;
	private Long InitiationId;
	private Long ReqMainId;
	private Long ReqParentId;
	private String RequirementName;
	private String RequirementDetails;
}
