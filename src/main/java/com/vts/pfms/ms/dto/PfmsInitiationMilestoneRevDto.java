package com.vts.pfms.ms.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class PfmsInitiationMilestoneRevDto {

	private long InitiationMileRevId;
	private long InitiationMilestoneId;
	private long InitiationId;
	private String PDRProbableDate;
	private String PDRActualDate;
	private String TIECProbableDate;
	private String TIECActualDate;
	private String CECProbableDate;
	private String CECActualDate;
	private String CCMProbableDate;
	private String CCMActualDate;
	private String DMCProbableDate;
	private String DMCActualDate;
	private String SanctionProbableDate;
	private String SanctionActualDate;
	private long Revision;
	private String Remarks;
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;
}
