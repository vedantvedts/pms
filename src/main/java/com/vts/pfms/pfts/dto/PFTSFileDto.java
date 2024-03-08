package com.vts.pfms.pfts.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PFTSFileDto {
	
	private Long PftsFileId;
	private String DemandType;
	private Long ProjectId;
	private String DemandNo;
	private Date DemandDate;
	private Double EstimatedCost;
	private String ItemNomenclature;
	private Date SpcDate;
	private Date EPCDate;
	private Date TenderDate;
	private Date TocDate;
	private Date TecDate;
	private Date TpcDate;
	private Date SanctionDate;
	private String OrderNo;
	private Date OrderDate;
	private Double OrderCost;
	private Date DpDate;
	private Date RevisedDp;
	private Date ReceiptDate;
	private Date InspectionDate;
	private Date CrvDate;
	private Date PaymentDate;
	private Date PartialChequeDate;
	private Date FinalChequeDate;
	private Long PftsStatusId;
	private String Remarks;
	private String PDC;
	private String IntegrationDate;
	private String EnvisagedStatus;
	private Date ProbableDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private Date PrbDateOfInti;
	private String EnvisagedFlag;
	private String ModifiedDate;

}
