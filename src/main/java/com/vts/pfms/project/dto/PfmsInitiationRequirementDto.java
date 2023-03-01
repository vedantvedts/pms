package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class PfmsInitiationRequirementDto {

	private Long InitiationReqId;
	private Long InitiationId;
	private String RequirementId;
	private Long ReqTypeId;
	private String RequirementBrief;
	private String RequirementDesc;
	private int ReqCount;
	private String priority;
	private String linkedRequirements;
}
