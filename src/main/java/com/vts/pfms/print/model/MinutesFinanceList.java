package com.vts.pfms.print.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "pfms_minutes_finance" )
public class MinutesFinanceList {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesFinanceId;
	private Long CommiteeScheduleId;
	private String BudgetHeadDescription;
	private Double TotalSanction;
	private Double ReSanction;
	private Double FeSanction;
	private Double ReExpenditure;
	private Double FeExpenditure;
	private Double ReOutCommitment;
	private Double FeOutCommitment;
	private Double ReDipl;
	private Double FeDipl;
	private Double ReBalance;
	private Double FeBalance;
	private Integer BudgetHeadId;
	private Long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	
}
