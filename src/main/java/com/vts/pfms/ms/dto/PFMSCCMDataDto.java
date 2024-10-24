package com.vts.pfms.ms.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PFMSCCMDataDto {
	
	private Long CCMDataId; 
	private long ClusterId;
	private String LabCode;
	private long ProjectId;
	private String ProjectCode;
	private long BudgetHeadId;
	private String BudgetHeadDescription;
	private BigDecimal AllotmentCost;
	private BigDecimal Expenditure;
	private BigDecimal Balance;
	private BigDecimal Q1CashOutGo;
	private BigDecimal Q2CashOutGo;
	private BigDecimal Q3CashOutGo;
	private BigDecimal Q4CashOutGo;
	private BigDecimal Required;
	private String CreatedDate;
}
