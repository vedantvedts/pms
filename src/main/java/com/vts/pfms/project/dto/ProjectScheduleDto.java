package com.vts.pfms.project.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProjectScheduleDto {

	private String MileStoneActivity;
	private String MileStoneMonth;
	private String MileStoneRemark;
	private int MilestoneTotalMonth;
	private int Milestonestartedfrom;
	private String InitiationScheduleId;
	private String FinancialOutlay;
	private String UserId;
	private Integer TotalMonth;
	private String InitiationId;
	private String ModifiedBy;
    private String ModifiedDate;

	
}
