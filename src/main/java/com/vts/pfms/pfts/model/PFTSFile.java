package com.vts.pfms.pfts.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

@Entity
@Table(name="pfts_file")
public class PFTSFile implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long PftsFileId;
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
		
}
