package com.vts.pfms.print.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "pfms_minutes_procurement" )
public class MinutesProcurementList {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesProcurementId;
	private Long CommiteeScheduleId;
	private Long PftsFileId;
	private String DemandNo;
	private String OrderNo;
	private String DemandDate;
	private String DpDate;
	private Double EstimatedCost;
	private Double OrderCost;
	private String RevisedDp;
	private String ItemNomenclature;
	private String PftsStatus;
	private String PftsStageName;
	private String Remarks;
	private String VendorName;
	private Long PftsStatusId;
	private String CreatedBy;
	private String CreatedDate;
}
