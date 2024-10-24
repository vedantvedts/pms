package com.vts.pfms.ms.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProjectHoaDto {

	private Long ProjectHoaId;
	private Long ProjectId;
	private String ProjectCode;
	private Long BudgetHeadId;
	private Long ProjectSanctionId;
	private Long BudgetItemId;
	private String ReFe;
	private Double SanctionCost;
	private Double Expenditure;
	private Double OutCommitment;
	private Double Dipl;
	private Double Balance;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String LabCode;
}
